defmodule AdventOfCode.Day01Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day01

  describe "part one" do
    test "with example input" do
      # Arrange
      input = """
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
      """

      # Act
      assert Day01.part_1(input) == 11
    end

    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_01.txt")

      # Act
      assert Day01.part_1(input) == 1_341_714
    end
  end

  describe "part two" do
    test "with example input" do
      # Arrange
      input = """
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
      """

      # Act
      assert Day01.part_2(input) == 31
    end

    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_01.txt")

      # Act
      assert Day01.part_2(input) == 27_384_707
    end
  end
end
