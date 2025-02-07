defmodule GetPrimes.GetPrimesMapSieve do
  @behaviour PrimeGetter

  @moduledoc """
  Implementation of the Sieve of Eratosthenes using a Map

  The Map holds one 'hole' of the sieve for each discovered prime at a time

  Lazy and pretty fast
  """

  alias GetPrimes.Utils.SieveMap

  def get_primes(n) do
    Stream.iterate({%{}, 1, false}, &SieveMap.update_map_sieve/1)
    |> Stream.filter(fn {_, _, is_prime} -> is_prime end)
    |> Stream.map(fn {_, num, _} -> num end)
    |> Enum.take(n)
  end
end
