defmodule Day01 do
  def run do
    lines =
      "input.txt"
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&part1_parse/1)

    # IO.inspect(lines)
    result = part1_solve(lines, 50)
    IO.inspect("part 1")
    IO.inspect(result)

    result = part2_solve(lines, 50)
    IO.inspect("part 2")
    IO.inspect(result)
  end

  def part1_parse("L" <> string_number) do
    {:left, String.to_integer(string_number)}
  end

  def part1_parse("R" <> string_number) do
    {:right, String.to_integer(string_number)}
  end

  def part1_solve([], _) do
    0
  end

  def part1_solve([{_, 0} | t], 0) do
    1 + part1_solve(t, 0)
  end

  def part1_solve([{_, 0} | t], p) do
    part1_solve(t, p)
  end

  def part1_solve([{:left, k} | t], p) do
    new_value = Integer.mod(p - 1, 100)
    part1_solve([{:left, k - 1} | t], new_value)
  end

  def part1_solve([{:right, k} | t], p) do
    new_value = Integer.mod(p + 1, 100)
    part1_solve([{:right, k - 1} | t], new_value)
  end

  # Part two
  def part2_solve([], _) do
    0
  end

  def part2_solve([{_, 0} | t], p) do
    part2_solve(t, p)
  end

  def part2_solve([{:left, k} | t], 0) do
    1 + part2_solve([{:left, k - 1} | t], 99)
  end

  def part2_solve([{:right, k} | t], 0) do
    1 + part2_solve([{:right, k - 1} | t], 1)
  end

  def part2_solve([{:left, k} | t], p) do
    new_value = Integer.mod(p - 1, 100)
    part2_solve([{:left, k - 1} | t], new_value)
  end

  def part2_solve([{:right, k} | t], p) do
    new_value = Integer.mod(p + 1, 100)
    part2_solve([{:right, k - 1} | t], new_value)
  end
end
