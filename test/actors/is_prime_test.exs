defmodule Actors.IsPrimeTest do
  use ExUnit.Case

  alias GetPrimes.Actors.IsPrime

  # setup do
  # IsPrime.start_link()
  # end

  test "it should initialise with a prime" do
    IsPrime.start_link()
    assert IsPrime.get_primes() == [2]
  end

  test "it should initialise with given primes" do
    IsPrime.start_link([2, 3])
    assert IsPrime.get_primes() == [2, 3]
  end

  test "it should update with a new prime" do
    IsPrime.start_link()
    IsPrime.prime_update(3)

    assert IsPrime.get_primes() == [2, 3]
  end

  test "it should not update with a number with factors" do
    IsPrime.start_link([2, 3])
    IsPrime.prime_update(4)

    assert IsPrime.get_primes() == [2, 3]
  end

  test "it should return true and update with a new prime" do
    IsPrime.start_link()

    assert IsPrime.is_prime_update?(3) == true
    assert IsPrime.get_primes() == [2, 3]
  end

  test "it should return false and not update with a number with factors" do
    IsPrime.start_link([2, 3])

    assert IsPrime.is_prime_update?(4) == false
    assert IsPrime.get_primes() == [2, 3]
  end
end
