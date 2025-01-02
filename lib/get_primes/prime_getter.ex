defmodule PrimeGetter do

  @doc """
  Returns a list of the first n prime numbers where n is a given positive integer

  ## Examples

    iex> G.get_primes(5)
    [2, 3, 5, 7, 11]
  """
  @callback get_primes(n :: pos_integer) :: [pos_integer]
end
