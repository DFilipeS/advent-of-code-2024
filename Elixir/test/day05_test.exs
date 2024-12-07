defmodule AdventOfCode.Day05Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day05

  doctest Day05

  setup do
    input = """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """

    [input: input]
  end

  describe "part one" do
    test "with example input", %{input: input} do
      # Act
      assert Day05.part_1(input) == 143
    end

    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_05.txt")

      # Act
      assert Day05.part_1(input) == 5275
    end
  end

  describe "part two" do
    test "with example input", %{input: input} do
      # Act
      assert Day05.part_2(input) == 123
    end

    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_05.txt")

      # Act
      assert Day05.part_2(input) == 6191
    end
  end
end
