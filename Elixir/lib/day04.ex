defmodule AdventOfCode.Day04 do
  @directions for x <- -1..1, y <- -1..1, {x, y} != {0, 0}, do: {x, y}

  @doc """
  Counts the number of occurrence of the word "XMAS" in the given `input`.

  ## Examples

      iex> input = "MMMSXXMASM\\nMSAMXMSMSA\\nAMXSXMAAMM\\nMSAMASMSMX\\nXMASAMXAMM\\nXXAMMXXAMA\\nSMSMSASXSS\\nSAXAMASAAA\\nMAMMMXMMMM\\nMXMXAXMASX"
      iex> AdventOfCode.Day04.part_1(input)
      18

  """
  def part_1(input) do
    grid = parse_input(input)

    grid
    |> Enum.filter(fn {_key, value} -> value == "X" end)
    |> Enum.reduce(0, fn {position, _value}, acc ->
      acc + find_words_in_all_directions(grid, position)
    end)
  end

  @doc """
  Counts the number of occurrence of the word "MAS" in shape of an "X" in the 
  given `input`.

  ## Examples

      iex> input = "MMMSXXMASM\\nMSAMXMSMSA\\nAMXSXMAAMM\\nMSAMASMSMX\\nXMASAMXAMM\\nXXAMMXXAMA\\nSMSMSASXSS\\nSAXAMASAAA\\nMAMMMXMMMM\\nMXMXAXMASX"
      iex> AdventOfCode.Day04.part_2(input)
      9

  """
  def part_2(input) do
    grid = parse_input(input)

    grid
    |> Enum.filter(fn {_key, value} -> value == "A" end)
    |> Enum.filter(fn {{x, y}, _value} ->
      a1 = Map.get(grid, {x - 1, y - 1})
      a2 = Map.get(grid, {x + 1, y + 1})

      b1 = Map.get(grid, {x + 1, y - 1})
      b2 = Map.get(grid, {x - 1, y + 1})

      Enum.sort([a1, a2]) == ["M", "S"] and Enum.sort([b1, b2]) == ["M", "S"]
    end)
    |> Enum.count()
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      String.split(line, "", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {value, x}, acc ->
        Map.put(acc, {x, y}, value)
      end)
      |> Map.merge(acc)
    end)
  end

  # Helper functions

  defp find_words_in_all_directions(grid, {x, y}) do
    Enum.reduce(@directions, 0, fn {dx, dy}, acc ->
      word =
        1..3
        |> Enum.map(&Map.get(grid, {x + dx * &1, y + dy * &1}))
        |> Enum.join()

      if word == "MAS", do: acc + 1, else: acc
    end)
  end
end
