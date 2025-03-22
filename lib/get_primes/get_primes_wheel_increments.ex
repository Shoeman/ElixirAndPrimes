defmodule GetPrimes.GetPrimesWheelIncrements do
  @behaviour PrimeGetter
  @moduledoc """
  Wheel factorisation approach to generating primes, creates 'wheels' from the @init_primes attribute

  This one uses increments between numbers on the wheel rather than relative to the start

  Lazier approach than get_primes_wheel since it makes use of the aptly named Stream.cycle() to apply the increments

  Perfomance held back by the is_prime? check, but this could be changed/improved independently of the wheel approach
  """

  @init_primes [2, 3, 5, 7]

  alias GetPrimes.Utils.GetWheelIncrements

  # Similar handling when n is low to the offset wheel method
  def get_primes(n) when n == 0 do
    []
  end

  def get_primes(n) when n <= length(@init_primes) do
    Enum.slice(@init_primes, 0..(n - 1))
  end

  def get_primes(n) do
    wheel_increments = GetWheelIncrements.get_wheel_increments(@init_primes)

    # Consider performance with big wheels
    first_wheel_prime = 1 + List.last(wheel_increments)

    # Do not check @init_primes as they are already filtered
    is_prime? = check_divisors_from(first_wheel_prime)

    wheel_stream =
      Stream.cycle(wheel_increments)
      |> Stream.scan(first_wheel_prime, &(&1 + &2))
      |> Stream.filter(is_prime?)

    Stream.concat(@init_primes, [first_wheel_prime])
    |> Stream.concat(wheel_stream)
    |> Enum.take(n)
  end

  def check_divisors_from(init_divisor) do
    fn likely_prime ->
      Stream.iterate(init_divisor, &(&1 + 2))
      |> Stream.take_while(&(&1 * &1 <= likely_prime))
      |> Enum.all?(&(rem(likely_prime, &1) != 0))
    end
  end
end
