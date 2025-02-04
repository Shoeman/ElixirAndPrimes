defmodule GetPrimes.GetPrimesHuman do
  @moduledoc """
  Possibly a further refinement of naive method, taking an approach that a human may do

  In batches of 10 at a time, only check odd numbers, excluding numbers ending in 5 (after 10)

  Possible precursor to a factorisation wheel
  """

  @offsets [1, 3, 7, 9]
  @init_primes [2, 3, 5, 7]

  def get_primes(n) when n == 0 do
    []
  end

  def get_primes(n) when n <= length(@init_primes) do
    Enum.slice(@init_primes, 0..(n - 1))
  end

  def get_primes(n) do
    found_primes =
      Stream.iterate(10, &(&1 + 10))
      |> Stream.map(&get_next_batch/1)
      |> Stream.flat_map(&Function.identity/1)
      |> Stream.transform(@init_primes, fn i, acc ->
        if is_new_prime(acc, i) do
          {[i], acc ++ [i]}
        else
          {[], acc}
        end
      end)
      |> Enum.take(n - length(@init_primes))

    @init_primes ++ found_primes
  end

  defp get_next_batch(start) do
    Enum.map(@offsets, &(&1 + start))
  end

  defp is_new_prime(previous_primes, x) do
    Stream.take_while(previous_primes, &(&1 * &1 <= x))
    |> Enum.all?(&(rem(x, &1) != 0))
  end
end
