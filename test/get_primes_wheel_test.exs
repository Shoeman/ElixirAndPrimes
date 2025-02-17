defmodule GetPrimesWheelTest do
  use ExUnit.Case

  alias GetPrimes.GetPrimesWheel
  alias GetPrimesWheel, as: G

  doctest PrimeGetter

  test "0 returns empty" do
    result = G.get_primes(0)

    assert result == []
  end

  test "1 returns a prime" do
    result = G.get_primes(1)

    assert result == [2]
  end

  test "2 returns multiple primes" do
    result = G.get_primes(2)

    assert result == [2, 3]
  end

  test "3 returns multiple primes" do
    result = G.get_primes(3)

    assert result == [2, 3, 5]
  end

  test "10 primes" do
    result = G.get_primes(10)

    assert result == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
  end

  test "11 primes tips it over the edge of the first turn" do
    result = G.get_primes(11)

    assert result == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
  end

  test "100 returns multiple primes" do
    result = G.get_primes(100)

    assert result == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541]
  end

  @tag :skip
  @tag timeout: 10_000
  test "it handles many primes" do
    result = G.get_primes(50000)

    assert length(result) == 50000
  end
end
