defmodule AdventOfCode.Day07Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day07

  doctest Day07

  setup do
    input = """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """

    [input: input]
  end

  describe "part one" do
    test "with example input", %{input: input} do
      # Act
      assert Day07.part_1(input) == 3749
    end

    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_07.txt")

      # Act
      assert Day07.part_1(input) == 3_245_122_495_150
    end
  end

  describe "part two" do
    test "with example input", %{input: input} do
      # Act
      assert Day07.part_2(input) == 11387
    end

    # test "with real input" do
    #   # Arrange
    #   input = File.read!("../inputs/day_07.txt")

    #   # Act
    #   assert Day07.part_2(input) == 4722
    # end
  end
end
