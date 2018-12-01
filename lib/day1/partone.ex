defmodule AoC.DayOne.PartOne do
  alias AoC.DayOne.Common

  def main() do
    Common.read_input("lib/day1/input.txt")
    |> calculate_sum()
    |> IO.puts()
  end

  def calculate_sum(numbers) do
    Enum.sum(numbers)
  end
end
