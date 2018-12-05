defmodule AoC.DayFive.PartTwo do
  alias AoC.DayFive.Common

  @lower_upper_difference 32
  @lower_a 97
  @lower_z 122

  def main() do
    "lib/day5/input.txt"
    |> Common.read_input()
    |> process()
  end

  defp process(polymer) do
    Enum.reduce(@lower_a..@lower_z, Enum.count(polymer), fn lower_unicode, length ->
      higher_unicode = lower_unicode - @lower_upper_difference
      lower_character = <<lower_unicode::utf8>>
      higher_character = <<higher_unicode::utf8>>

      polymer_length =
        polymer
        |> Enum.filter(fn x -> x != lower_character and x != higher_character end)
        |> process_polymer()
        |> Enum.count()

      min(polymer_length, length)
    end)
  end

  defp process_polymer(polymer) do
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
