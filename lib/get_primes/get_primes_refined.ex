defmodule GetPrimes.GetPrimesRefined do
  @behaviour PrimeGetter
  @moduledoc """
  Refined naive approach to getting first N primes

  Uses previously calculated primes, up to the root of the dividend, as divisors when looking for new primes

  Builds tuples due to the need for multiple ordered traversals

  Also skips some work by only checking odd numbers (after 2)

  Still slow compared with other methods, but still lazy
  """

  @impl true
  def get_primes(n) when n == 0 do
    []
  end

  @impl true
  def get_primes(n) do
    Stream.unfold({2}, &{&1, Tuple.append(&1, get_next_prime(&1))})
    |> Enum.take(n)
    |> List.last()
    |> Tuple.to_list()
  end

  # Hardcode this case to make steps of 2 more convenient
  defp get_next_prime(previous_primes) when previous_primes == {2} do
    3
  end

  defp get_next_prime(previous_primes) do
    start = elem(previous_primes, tuple_size(previous_primes) - 1) + 2

    Stream.iterate(start, &(&1 + 2))
    |> Stream.filter(&is_new_prime(previous_primes, &1))
    |> Enum.take(1)
    |> hd()
  end

  defp is_new_prime(previous_primes, x) do
    Stream.iterate(1, &(&1 + 1))
    |> Stream.map(&elem(previous_primes, &1))
    |> Stream.take_while(&(&1 * &1 <= x))
    |> Enum.all?(&(rem(x, &1) != 0))
  end
end
