defmodule AdventOfCode.Day05 do
  def part_1(input) do
    {rules, updates} = parse_input(input)

    updates
    |> Enum.map(&if is_ordered?(rules, &1), do: get_middle(&1), else: 0)
    |> Enum.sum()
  end

  def part_2(input) do
    {rules, updates} = parse_input(input)

    updates
    |> Enum.reject(&is_ordered?(rules, &1))
    |> Enum.map(&fix_order(rules, &1))
    |> Enum.map(&get_middle/1)
    |> Enum.sum()
  end

  def is_ordered?(rules, values) do
    values
    |> Enum.with_index()
    |> Enum.reduce_while(true, fn {value, index}, _ ->
      {h, [_ | t]} = Enum.split(values, index)

      if Enum.all?(h, &(&1 in rules[value].after)) and Enum.all?(t, &(&1 in rules[value].before)) do
        {:cont, true}
      else
        {:halt, false}
      end
    end)
  end

  def get_middle(values), do: Enum.at(values, div(length(values), 2))

  def fix_order(rules, values) do
    Enum.reduce(values, [], &add_in_order(&2, &1, rules))
  end

  def add_in_order([], value, _rules), do: [value]

  def add_in_order([h | t], value, rules) do
    if h in rules[value].before do
      [value, h | t]
    else
      [h | add_in_order(t, value, rules)]
    end
  end

  # Functions to parse the input

  def parse_input(input) do
    [input_1, input_2] = String.split(input, "\n\n", trim: true)
    rules = parse_rules(input_1)
    updates = parse_updates(input_2)

    {rules, updates}
  end

  def parse_rules(input) do
    Enum.reduce(String.split(input, "\n"), %{}, fn line, acc ->
      [a, b] = String.split(line, "|") |> Enum.map(&String.to_integer/1)

      a_update =
        acc
        |> Map.get(a, %{before: [], after: []})
        |> Map.update!(:before, &[b | &1])

      b_update =
        acc
        |> Map.get(b, %{before: [], after: []})
        |> Map.update!(:after, &[a | &1])

      acc
      |> Map.put(a, a_update)
      |> Map.put(b, b_update)
    end)
  end

  def parse_updates(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
