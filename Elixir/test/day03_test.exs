defmodule AdventOfCode.Day03Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day03

  doctest Day03

  describe "part one" do
    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_03.txt")

      # Act
      assert Day03.part_1(input) == 174_103_751
    end
  end

  describe "part two" do
    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_03.txt")

      # Act
      assert Day03.part_2(input) == 100_411_201
    end
  end
end
