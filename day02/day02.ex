defmodule Day02 do
  require Integer

  def run do
    ranges =
      "input.txt"
      |> File.read!()
      |> String.trim("\n")
      |> String.split(",", trim: true)
      |> Enum.map(fn line -> String.split(line, "-") end)
      |> Enum.map(fn [s, t] -> {String.to_integer(s), String.to_integer(t)} end)

    res = solve(ranges, &invalids/2)
    IO.inspect(res)
    res = solve(ranges, &invalids_2/2)
    IO.inspect(res)
  end

  def solve(ranges, invalid_fun) do
    Enum.reduce(ranges, 0, fn {s, e}, acc -> acc + invalid_fun.(s, e) end)
  end

  def invalids(s, e) do
    s..e
    |> Enum.filter(&is_repeated_twice/1)
    |> Enum.sum()
  end

  def is_repeated_twice(num) do
    str = Integer.to_string(num)

    str_len =
      String.length(str)

    if Integer.is_odd(str_len) do
      false
    else
      {left, right} = String.split_at(str, div(str_len, 2))
      left == right
    end
  end

  def invalids_2(s, e) do
    s..e
    |> Enum.filter(&meet_condition/1)
    |> Enum.sum()
  end

  def meet_condition(num) do
    digits = Integer.digits(num)
    length = length(digits)

    case length do
      n when n <= 1 ->
        false

      n ->
        2..n
        |> Enum.filter(fn possible -> Integer.mod(length, possible) == 0 end)
        |> Enum.any?(fn chunk_size -> all_equal(digits, div(length, chunk_size)) end)
    end
  end

  def all_equal(digits, chunk_size) do
    digits
    |> Enum.chunk_every(chunk_size)
    |> Enum.uniq()
    |> length() <=
      1
  end
end
