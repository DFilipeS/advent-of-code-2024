defmodule AdventOfCode.Day07 do
  def part_1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_input/1)
    |> Enum.filter(&is_calibration_possible?/1)
    |> Enum.map(fn {total, _values} -> total end)
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_input/1)
    |> Enum.take(1)
  end

  def is_calibration_possible?({total, values}) do
    dbg(find_combinations(total, 0, values))
    find_combinations(total, 0, values) != :not_possible
  end

  def find_combinations(total, acc, [] = _values) when total == acc, do: []
  def find_combinations(_total, _acc, [] = _values), do: :not_possible

  def find_combinations(total, acc, [value | rest]) do
    case find_combinations(total, acc + value, rest) do
      :not_possible ->
        case find_combinations(total, acc * value, rest) do
          :not_possible ->
            :not_possible

          combinations ->
            ["*" | combinations]
        end

      combinations ->
        ["+" | combinations]
    end
  end

  # def find_combinations_with_concat(total, acc, [] = _values) when total == acc, do: []
  # def find_combinations_with_concat(_total, _acc, [] = _values), do: :not_possible

  # def find_combinations_with_concat(total, acc, [v1, v2 | rest]) do
  #   case find_combinations_with_concat(total, acc + value, rest) do
  #     :not_possible ->
  #       case find_combinations_with_concat(total, acc * value, rest) do
  #         :not_possible ->
  #           :not_possible

  #         combinations ->
  #           ["*" | combinations]
  #       end

  #     combinations ->
  #       ["+" | combinations]
  #   end
  # end

  # Functions to parse the input

  def parse_input(input) do
    [total, values] = String.split(input, ": ")
    total = String.to_integer(total)
    values = values |> String.split(" ") |> Enum.map(&String.to_integer/1)

    {total, values}
  end
end
