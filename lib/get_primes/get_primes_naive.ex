defmodule GetPrimes.GetPrimesNaive do
  @behaviour PrimeGetter

  @moduledoc """
  Naive approach to getting first N primes

  Slow but lazy
  """

  @impl true
  def get_primes(n) do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&is_prime(&1))
    |> Enum.take(n)
  end

  defp is_prime(x) when x == 2 do
    true
  end

  defp is_prime(x) do
    Enum.all?(2..(x - 1), &(rem(x, &1) != 0))
  end
end
