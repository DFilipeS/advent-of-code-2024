defmodule AdventOfCode.Day04Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day04

  doctest Day04

  describe "part one" do
    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_04.txt")

      # Act
      assert Day04.part_1(input) == 2567
    end
  end

  describe "part two" do
    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_04.txt")

      # Act
      assert Day04.part_2(input) == 2029
    end
  end
end
