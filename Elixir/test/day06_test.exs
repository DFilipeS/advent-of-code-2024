defmodule AdventOfCode.Day06Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day06

  doctest Day06

  setup do
    input = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

    [input: input]
  end

  describe "part one" do
    test "with example input", %{input: input} do
      # Act
      assert Day06.part_1(input) == 41
    end

    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_06.txt")

      # Act
      assert Day06.part_1(input) == 4722
    end
  end

  describe "part two" do
    test "with example input", %{input: input} do
      # Act
      assert Day06.part_2(input) == 6
    end

    @tag :skip
    test "with real input" do
      # Arrange
      input = File.read!("../inputs/day_06.txt")

      # Act
      assert Day06.part_2(input) == 1602
    end
  end
end
