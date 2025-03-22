defmodule GetPrimes.Utils.GetWheelIncrements do
  alias GetPrimes.Utils.GetWheelOffsets

  def get_wheel_increments(init_primes) do
    wheel_size = Enum.product(init_primes)

    get_increment = fn [first, second] -> second - rem(first, wheel_size) end

    wheel_offsets = GetWheelOffsets.get_wheel_offsets(init_primes, wheel_size)
    wheel_length = length(wheel_offsets)

    # Probably better done with indexes but this was fun!
    wheel_offsets
    |> Stream.cycle()
    |> Stream.chunk_every(2, 1)
    |> Stream.map(get_increment)
    |> Enum.take(wheel_length)
  end
end
