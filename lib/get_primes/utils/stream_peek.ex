defmodule GetPrimes.Utils.StreamPeek do
  @moduledoc """
  Look at the first item in a stream/enumerable and retain the whole stream

  This is essentially a stripped down version of StreamSplit:
   https://github.com/tallakt/stream_split
  """

  @enforce_keys [:continuation, :stream]
  defstruct @enforce_keys

  def peek(enum) do
    {[h], t} = head_and_tail(enum)
    {h, Stream.concat([h], t)}
  end

  @spec head_and_tail(Enumerable.t()) :: {List.t(), Enumerable.t()}
  def head_and_tail(enum) do
    # Perform a reduce and immediately suspend to get head and tail
    {:suspended, list, cont} = Enumerable.reduce(enum, {:cont, []}, &suspend_next/2)

    stream_split = %__MODULE__{continuation: cont, stream: continuation_to_stream(cont)}
    {list, stream_split}
  end

  defp suspend_next(item, _) do
    {:suspend, [item]}
  end

  defp continuation_to_stream(cont) do
    wrapped = fn {_, _, acc_cont} ->
      case acc_cont.({:cont, :tail}) do
        acc = {:suspended, item, _cont} -> {item, acc}
        {:halted, acc} -> {:halt, acc}
        {:done, acc} -> {:halt, acc}
      end
    end

    cleanup = fn
      {:suspended, _, acc_cont} -> acc_cont.({:halt, nil})
      _ -> nil
    end

    Stream.resource(fn -> {:suspended, nil, cont} end, wrapped, cleanup)
  end
end

defimpl Enumerable, for: GetPrimes.Utils.StreamPeek do
  def count(_stream_peek), do: {:error, __MODULE__}
  def member?(_stream_peek, _value), do: {:error, __MODULE__}
  def slice(_stream_peek), do: {:error, __MODULE__}

  def reduce(%GetPrimes.Utils.StreamPeek{stream: stream}, acc, fun) do
    Enumerable.reduce(stream, acc, fun)
  end
end
