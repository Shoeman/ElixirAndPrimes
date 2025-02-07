defmodule GetPrimes.Utils.SieveMap do
  # %{multiple => prime_factor}
  @type sieve_map() :: %{pos_integer() => pos_integer()}
  @type sieve_state() :: {sieve_map(), pos_integer(), boolean()}

  @spec update_map_sieve(sieve_state()) :: sieve_state()
  def update_map_sieve({sieve_map, last_num, _is_prime}) do
    to_check = last_num + 1

    case Map.pop(sieve_map, to_check) do
      {nil, popped_map} ->
        {Map.put(popped_map, to_check * to_check, to_check), to_check, true}

      {prime_factor, popped_map} ->
        {put_next_free_multiple(popped_map, prime_factor, to_check), to_check, false}
    end
  end

  # Check map for each multiple of prime after current and put first untaken key
  def put_next_free_multiple(map, prime, current) do
    to_check = current + prime

    if Map.has_key?(map, to_check) do
      put_next_free_multiple(map, prime, to_check)
    else
      Map.put(map, to_check, prime)
    end
  end
end
