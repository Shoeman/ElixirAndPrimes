defmodule GetPrimes.GetPrimesActorDemo do
  @moduledoc """
  Simple demo using the is_prime agent by simply feeding the agent incrementing numbers until n primes are found

  Could be somewhat more asynchronous if it didn't require the result of the agent update
  """

  alias GetPrimes.Actors.IsPrime
  @behaviour PrimeGetter

  @impl true
  def get_primes(n) when n == 0 do
    []
  end

  @impl true
  def get_primes(n) when n == 1 do
    [2]
  end

  @impl true
  def get_primes(n) do
    IsPrime.start_link()

    prime_stream =
      Stream.iterate(3, &(&1 + 1))
      |> Stream.filter(&IsPrime.is_prime_update?/1)

    Stream.concat([2], prime_stream)
    |> Enum.take(n)
  end
end
