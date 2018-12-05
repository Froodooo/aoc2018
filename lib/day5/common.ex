defmodule AoC.DayFive.Common do
  @lower_upper_unicode_difference 32

  def read_input(path) do
    path
    |> File.read!()
    |> String.graphemes()
  end

  def process(polymer) do
    polymer
    |> Enum.reduce([], fn unit, result -> process_unit(unit, result) end)
  end

  def get_lower_upper_unicode_difference() do
    @lower_upper_unicode_difference
  end

  defp process_unit(unit, []) do
    [unit]
  end

  defp process_unit(unit, polymer) do
    [head | rest] = polymer
    <<h::utf8>> = head
    <<u::utf8>> = unit

    case abs(h - u) do
      @lower_upper_unicode_difference -> rest
      _ -> [unit | polymer]
    end
  end
end
