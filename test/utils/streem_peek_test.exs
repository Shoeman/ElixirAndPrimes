defmodule StreemPeekTest do
  use ExUnit.Case

  alias GetPrimes.Utils.StreamPeek

  test "a stream can be peaked" do
    stream = Stream.map([1, 2, 3], &(&1));

    {head, tail} = StreamPeek.peek(stream);

    assert head == 1
    assert tail |> Enum.to_list() == [1, 2, 3]
  end

end
