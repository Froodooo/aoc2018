defmodule AoC.DayTwo.PartOne do
  alias AoC.DayTwo.Common

  def main() do
    "lib/day2/input.txt"
    |> Common.read_input()
    |> Enum.map(&count_characters/1)
    |> Enum.map(&Map.values/1)
    |> get_multiplicants()
    |> Enum.reduce(1, fn x, acc -> acc * x end)
  end

  defp count_characters(box_id) do
    box_id
    |> String.graphemes()
    |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, x, (acc[x] || 0) + 1) end)
  end

  defp get_multiplicants(occurrences_lists) do
    twos =
      Enum.reduce(occurrences_lists, 0, fn x, acc ->
        if Enum.member?(x, 2), do: acc + 1, else: acc
      end)

    threes =
      Enum.reduce(occurrences_lists, 0, fn x, acc ->
        if Enum.member?(x, 3), do: acc + 1, else: acc
      end)

    [twos, threes]
  end
end
