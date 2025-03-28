defmodule GetPrimes.Actors.IsPrime do
  @moduledoc """
  An actor/agent to validate primes and manage state of validated primes

  General idea is that validating primes benefits from knowing previous primes so should own that state

  This helps separate the responsibilities of generating possible primes and validating them
  """
  use Agent

  def start_link() do
    start_link([2])
  end

  def start_link(init_primes) do
    Agent.start_link(fn -> init_primes end, name: __MODULE__)
  end

  def get_primes() do
    Agent.get(__MODULE__, & &1)
  end

  @doc """
  Feeds the agent a potental prime, updates the current primes if n is prime

  Returns true if n was prime

  Useful for when prime methods need to know when their number was prime
  """
  def is_prime_update?(n) do
    Agent.get_and_update(__MODULE__, fn current_primes ->
      if is_prime?(n, current_primes) do
        {true, current_primes ++ [n]}
      else
        {false, current_primes}
      end
    end)
  end

  @doc """
  Feeds the agent a potental prime, updates the current primes if n is prime

  Useful for when prime methods do not (synchronously) need to know if their number was prime.
  """
  def prime_update(n) do
    Agent.update(__MODULE__, fn current_primes ->
      if is_prime?(n, current_primes) do
        current_primes ++ [n]
      else
        current_primes
      end
    end)
  end

  defp is_prime?(n, current_primes) do
    Stream.take_while(current_primes, fn prime -> prime * prime <= n end)
    |> Enum.all?(fn prime -> rem(n, prime) != 0 end)
  end
end
