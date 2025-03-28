defmodule GetPrimesActorDemo do
  use ExUnit.Case

  alias GetPrimes.GetPrimesActorDemo
  alias GetPrimesActorDemo, as: G

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

  test "10 primes" do
    result = G.get_primes(10)

    assert result == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
  end

  @tag :skip
  @tag timeout: 10_000
  test "it handles many primes" do
    result = G.get_primes(20000)

    assert length(result) == 20000
  end
end
