defmodule Utils.GetWheelIncrementsTest do
  use ExUnit.Case

  alias GetPrimes.Utils.GetWheelIncrements

  test "wheel of 2 primes" do
    init_primes = [2, 3]
    # Wheel is [5, 7]

    result = GetWheelIncrements.get_wheel_increments(init_primes)

    assert result == [2, 4]
  end

  test "wheel of 3 primes" do
    init_primes = [2, 3, 5]

    result = GetWheelIncrements.get_wheel_increments(init_primes)

    # wheel is [7, 11, 13, 17, 19, 23, 29, 31]
    expected = [4, 2, 4, 2, 4, 6, 2, 6]

    assert result == expected
  end
end
