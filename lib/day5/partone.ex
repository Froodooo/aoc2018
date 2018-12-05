defmodule AoC.DayFive.PartOne do
  alias AoC.DayFive.Common

  @lower_upper_difference 32

  def main() do
    "lib/day5/input.txt"
    |> Common.read_input()
    |> process()
    |> Enum.count()
  end

  defp process(polymer) do
    polymer
    |> Enum.reduce([], fn unit, result -> process_unit(unit, result) end)
  end

  defp process_unit(unit, []) do
    [unit]
  end

  defp process_unit(unit, polymer) do
    [head | rest] = polymer
    <<h::utf8>> = head
    <<u::utf8>> = unit

    case abs(h - u) do
      @lower_upper_difference -> rest
      _ -> [unit | polymer]
    end
  end
end
