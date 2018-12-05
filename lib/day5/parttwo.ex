defmodule AoC.DayFive.PartTwo do
  alias AoC.DayFive.Common

  @lower_a 97
  @lower_z 122

  def main() do
    "lib/day5/input.txt"
    |> Common.read_input()
    |> process()
  end

  defp process(polymer) do
    Enum.reduce(@lower_a..@lower_z, Enum.count(polymer), fn lower_unicode, length ->
      higher_unicode = lower_unicode - Common.get_lower_upper_unicode_difference()
      lower_character = <<lower_unicode::utf8>>
      higher_character = <<higher_unicode::utf8>>

      polymer_length =
        polymer
        |> Enum.filter(fn x -> x != lower_character and x != higher_character end)
        |> Common.process()
        |> Enum.count()

      min(polymer_length, length)
    end)
  end
end
