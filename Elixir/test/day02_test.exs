defmodule AdventOfCode.Day02Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day02

  doctest Day02

  describe "part one" do
    test "with example input" do
      # Arrange
      input = """
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
      """

      # Act
      assert Day02.part_1(input) == 2
    end

    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_02.txt")

      # Act
      assert Day02.part_1(input) == 356
    end
  end

  describe "part two" do
    test "with example input" do
      # Arrange
      input = """
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
      """

      # Act
      assert Day02.part_2(input) == 4
    end

    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_02.txt")

      # Act
      assert Day02.part_2(input) == 413
    end
  end
end
