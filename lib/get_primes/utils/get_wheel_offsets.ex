defmodule GetPrimes.Utils.GetWheelOffsets do

  @moduledoc """
  Get the offsets of a wheel relative to the wheel start
  """

  def get_wheel_offsets(init_primes, wheel_size) do

    start = List.last(init_primes) + 1

    start..(wheel_size + 1)
    |> Stream.filter(&has_no_factor?(init_primes, &1))
    |> Enum.to_list()
  end

  # Sieving one factor at a time may be quicker for larger wheels
  def has_no_factor?(prime_factors, n) do
    Enum.all?(prime_factors, &(rem(n, &1) != 0))
  end
end
