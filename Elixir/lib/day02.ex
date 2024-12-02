defmodule AdventOfCode.Day02 do
  def part_1(input) do
    input
    |> parse_input()
    |> Enum.filter(&is_safe_report?/1)
    |> Enum.count()
  end

  def part_2(input) do
    input
    |> parse_input()
    |> Enum.filter(&is_almost_safe_report?/1)
    |> Enum.count()
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Checks if the given report is safe or not. The report is considered safe if
  the levels are either all increasing or all decreasing and any two adjacent 
  levels differ by at least one and at most three.

  ## Examples

      iex> AdventOfCode.Day02.is_safe_report?([7, 6, 4, 2, 1])
      true

      iex> AdventOfCode.Day02.is_safe_report?([1, 2, 7, 8, 9])
      false

      iex> AdventOfCode.Day02.is_safe_report?([9, 7, 6, 2, 1])
      false

      iex> AdventOfCode.Day02.is_safe_report?([1, 3, 2, 4, 5])
      false

      iex> AdventOfCode.Day02.is_safe_report?([8, 6, 4, 4, 1])
      false

      iex> AdventOfCode.Day02.is_safe_report?([1, 3, 6, 7, 9])
      true
  """
  def is_safe_report?([x, y | _rest] = report) do
    mode = if x < y, do: :asc, else: :desc

    check_levels(report, mode)
  end

  @doc """
  Checks if the given report is almost safe or not. The report is considered 
  safe if the levels are either all increasing or all decreasing and any two 
  adjacent levels differ by at least one and at most three. To be considered
  almost safe is if the report becomes safe if one value is removed.

  ## Examples

      iex> AdventOfCode.Day02.is_almost_safe_report?([7, 6, 4, 2, 1])
      true

      iex> AdventOfCode.Day02.is_almost_safe_report?([1, 2, 7, 8, 9])
      false

      iex> AdventOfCode.Day02.is_almost_safe_report?([9, 7, 6, 2, 1])
      false

      iex> AdventOfCode.Day02.is_almost_safe_report?([1, 3, 2, 4, 5])
      true

      iex> AdventOfCode.Day02.is_almost_safe_report?([8, 6, 4, 4, 1])
      true

      iex> AdventOfCode.Day02.is_almost_safe_report?([1, 3, 6, 7, 9])
      true
  """
  def is_almost_safe_report?(report, index \\ 0) do
    index < length(report) and
      (is_safe_report?(report) or
         is_safe_report?(List.delete_at(report, index)) or
         is_almost_safe_report?(report, index + 1))
  end

  # Helper functions

  defp check_levels([_], _mode), do: true

  defp check_levels([x, y | rest], :asc = mode) do
    x < y and abs(x - y) <= 3 and check_levels([y | rest], mode)
  end

  defp check_levels([x, y | rest], :desc = mode) do
    x > y and abs(x - y) <= 3 and check_levels([y | rest], mode)
  end
end
