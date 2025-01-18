defmodule GetPrimes.GetPrimesSlowSieve do
  @moduledoc """
  Get first n primes using the sieve of Eratosthenes in the form of a 'lazy' Stream

  Unfortunately _very_ slow implementation likely due to the multiple streams/reductions created for the sieve
  """

  alias GetPrimes.Utils.StreamPeek

  def get_primes(n) when n == 0 do
    []
  end

  def get_primes(n) do
    Stream.iterate({2, Stream.iterate(2, &(&1 + 1))}, &filter_next_prime/1)
    |> Stream.map(fn {prime, _} -> prime end)
    |> Enum.take(n)
  end

  defp filter_next_prime({curr_prime, sieve_stream}) do
    nxt_sieve =
      sieve_stream
      |> Stream.map_every(curr_prime, fn _ -> 0 end)
      |> Stream.drop_while(fn x -> x == 0 end)

    StreamPeek.peek(nxt_sieve)
  end
end
