defmodule GetPrimes.GetPrimesWheel do
  @behaviour PrimeGetter
  @moduledoc """
  Wheel factorisation approach to generating primes, creates 'wheels' from the @init_primes attribute

  Speed and laziness depends on the wheel size: larger wheels in theory are faster but more eager as batches are generated per wheel 'rotation'

  Perfomance held back by the is_prime? check, but this could be changed/improved independently of the wheel approach
  """

  @init_primes [2, 3, 5, 7]

  alias GetPrimes.Utils.GetWheelOffsets

  def get_primes(n) when n == 0 do
    []
  end

  def get_primes(n) when n <= length(@init_primes) do
    Enum.slice(@init_primes, 0..(n - 1))
  end

  def get_primes(n) do
    wheel_size = Enum.product(@init_primes)
    wheel_offsets = GetWheelOffsets.get_wheel_offsets(@init_primes, wheel_size)
    first_unsieved_prime = List.first(wheel_offsets)

    # Do not check @init_primes as they are already filtered
    is_prime? = check_divisors_from(first_unsieved_prime)

    wheel_stream =
      Stream.iterate(0, &(&1 + wheel_size))
      |> Stream.map(&get_next_batch(&1, wheel_offsets))
      |> Stream.flat_map(&Function.identity/1)
      |> Stream.filter(is_prime?)

    Stream.concat(@init_primes, wheel_stream)
    |> Enum.take(n)
  end

  defp get_next_batch(start, wheel_offsets) do
    Enum.map(wheel_offsets, &(&1 + start))
  end

  def check_divisors_from(init_divisor) do
    fn likely_prime ->
      Stream.iterate(init_divisor, &(&1 + 2))
      |> Stream.take_while(&(&1 * &1 <= likely_prime))
      |> Enum.all?(&(rem(likely_prime, &1) != 0))
    end
  end
end
