defmodule AdventOfCode.Day01 do
  def part_1(input) do
    input
    |> parse_input()
    |> then(fn {left, right} -> Enum.zip(Enum.sort(left), Enum.sort(right)) end)
    |> Enum.map(fn {x, y} -> abs(x - y) end)
    |> Enum.sum()
  end

  def part_2(input) do
    {left, right} = parse_input(input)
    frequencies = Enum.frequencies(right)

    Enum.reduce(left, 0, fn value, acc ->
      acc + value * Map.get(frequencies, value, 0)
    end)
  end

  # Helper functions

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({[], []}, fn line, {left, right} ->
      [x, y] = String.split(line, " ", trim: true)
      {[String.to_integer(x) | left], [String.to_integer(y) | right]}
    end)
  end
end
