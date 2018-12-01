defmodule AoC.DayOne.PartTwo do
  alias AoC.DayOne.Common

  def main() do
    Common.read_input("lib/day1/input.txt")
    |> calculate_result()
    |> IO.puts()
  end

  def calculate_result(numbers, frequencies \\ [], base \\ 0, index \\ 0)

  def calculate_result(numbers, frequencies, base, index) when index == length(numbers) do
    calculate_result(numbers, frequencies, base, 0)
  end

  def calculate_result(numbers, frequencies, base, index) do
    base = base + Enum.at(numbers, index)
    if (Enum.member?(frequencies, base)) do
      base
    else
      frequencies = [base | frequencies]
      calculate_result(numbers, frequencies, base, index + 1)
    end
  end
end
