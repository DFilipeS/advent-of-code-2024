defmodule AdventOfCode.Day06 do
  def part_1(input) do
    {positions, start, width, height} = parse_input(input)
    bounds = {width, height}

    simulate_movement(positions, bounds, start)
    |> Enum.map(&elem(&1, 0))
    |> Enum.uniq()
    |> Enum.count()
  end

  def part_2(input) do
    {positions, start, width, height} = parse_input(input)
    bounds = {width, height}

    simulate_movement(positions, bounds, start)
    |> Stream.chunk_every(100)
    |> Enum.map(fn chunk ->
      Task.async(fn ->
        Enum.reduce(chunk, MapSet.new(), fn {{x, y} = _position, {dx, dy} = _direction}, acc ->
          next_position = {x + dx, y + dy}
          positions = Map.put(positions, next_position, "#")

          if simulate_movement(positions, bounds, start) == :loop_detected do
            MapSet.put(acc, next_position)
          else
            acc
          end
        end)
      end)
    end)
    |> Task.await_many()
    |> Enum.reduce(MapSet.new(), &MapSet.union(&1, &2))
    |> Enum.count()
  end

  def simulate_movement(
        positions,
        bounds,
        position,
        direction \\ {0, -1},
        visited \\ MapSet.new()
      )

  def simulate_movement(_positions, {width, height}, {x, y}, _direction, _visited)
      when x < 0 or y < 0 or x >= width or y >= height,
      do: []

  def simulate_movement(positions, bounds, {x, y} = position, {dx, dy} = direction, visited) do
    if MapSet.member?(visited, {position, direction}) do
      :loop_detected
    else
      next_position = {x + dx, y + dy}

      if Map.has_key?(positions, next_position) do
        visited = MapSet.put(visited, {position, direction})
        next_direction = switch_direction(direction)

        simulate_movement(positions, bounds, position, next_direction, visited)
      else
        visited = MapSet.put(visited, {position, direction})

        case simulate_movement(positions, bounds, next_position, direction, visited) do
          :loop_detected -> :loop_detected
          steps -> [{position, direction} | steps]
        end
      end
    end
  end

  def switch_direction({0, -1}), do: {1, 0}
  def switch_direction({1, 0}), do: {0, 1}
  def switch_direction({0, 1}), do: {-1, 0}
  def switch_direction({-1, 0}), do: {0, -1}

  # Functions to parse the input

  def parse_input(input) do
    lines = String.split(input, "\n", trim: true)

    positions = parse_positions(lines)
    start = parse_start_position(lines)
    width = String.length(Enum.at(lines, 0))
    height = Enum.count(lines)

    {positions, start, width, height}
  end

  def parse_positions(lines) do
    lines
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      line
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.filter(fn {value, _} -> value == "#" end)
      |> Enum.reduce(acc, fn {value, x}, acc ->
        Map.put(acc, {x, y}, value)
      end)
    end)
  end

  def parse_start_position(lines) do
    lines
    |> Enum.with_index()
    |> Enum.find_value(fn {line, y} ->
      line
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.find_value(fn {value, x} ->
        value == "^" and {x, y}
      end)
    end)
  end
end
