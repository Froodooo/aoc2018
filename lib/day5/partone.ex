defmodule AoC.DayFive.PartOne do
  alias AoC.DayFive.Common

  def main() do
    "lib/day5/input.txt"
    |> Common.read_input()
    |> Common.process()
    |> Enum.count()
  end
end
