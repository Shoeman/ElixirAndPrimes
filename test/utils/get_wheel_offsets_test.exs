defmodule Utils.GetWheelOffsetsTest do
  use ExUnit.Case

  alias GetPrimes.Utils.GetWheelOffsets

  test "wheel of 2 primes" do
    init_primes = [2, 3]

    result = GetWheelOffsets.get_wheel_offsets(init_primes, 6)

    assert result == [5, 7]
  end

  test "wheel of 3 primes" do
    init_primes = [2, 3, 5]

    result = GetWheelOffsets.get_wheel_offsets(init_primes, 30)

    expected_offsets = [7, 11, 13, 17, 19, 23, 29, 31]

    assert result == expected_offsets
  end

  test "wheel of 4 primes" do
    init_primes = [2, 3, 5, 7]

    result = GetWheelOffsets.get_wheel_offsets(init_primes, 210)

    expected_offsets = [
      11,
      13,
      17,
      19,
      23,
      29,
      31,
      37,
      41,
      43,
      47,
      53,
      59,
      61,
      67,
      71,
      73,
      79,
      83,
      89,
      97,
      101,
      103,
      107,
      109,
      113,
      121,
      127,
      131,
      137,
      139,
      143,
      149,
      151,
      157,
      163,
      167,
      169,
      173,
      179,
      181,
      187,
      191,
      193,
      197,
      199,
      209,
      211
    ]

    assert result == expected_offsets
  end
end
