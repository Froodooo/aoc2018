defmodule AoC.DayThree.PartOne do
  alias AoC.DayThree.Common

  def main() do
    "lib/day3/input.txt"
    |> Common.read_input()
    |> Common.parse_into_structs()
    |> Common.get_fabric()
    |> Enum.filter(fn {_key, value} -> value > 1 end)
    |> Enum.count()
  end
end
