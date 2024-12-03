defmodule AdventOfCode.Day03 do
  @doc """
  Finds uncorrupted instructions in the `input` string and executes them. Returns
  the sum of every multiplication.

  ## Examples

      iex> input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
      iex> AdventOfCode.Day03.part_1(input)
      161

  """
  def part_1(input) do
    ~r/mul\((?<foo>\d+),(?<bar>\d+)\)/
    |> Regex.scan(input, capture: ["foo", "bar"])
    |> Enum.map(fn [x, y] ->
      String.to_integer(x) * String.to_integer(y)
    end)
    |> Enum.sum()
  end

  @doc """
  Finds the uncorrupted instructions in the `input` string, checks for
  conditionals and executes the, Return the sum of every active multiplication.

  ## Examples

      iex> input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
      iex> AdventOfCode.Day03.part_2(input)
      48
  """
  def part_2(input) do
    ~r/mul\((?<foo>\d+),(?<bar>\d+)\)|(?<do>do\(\))|(?<dont>don't\(\))/
    |> Regex.scan(input, capture: ["foo", "bar", "do", "dont"])
    |> Enum.reduce({:active, 0}, fn
      [x, y, "", ""], {:active, acc} ->
        {:active, String.to_integer(x) * String.to_integer(y) + acc}

      ["", "", "do()", ""], {_, acc} ->
        {:active, acc}

      ["", "", "", "don't()"], {_, acc} ->
        {:inactive, acc}

      _, acc ->
        acc
    end)
    |> elem(1)
  end
end
