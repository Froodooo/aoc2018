defmodule AoC.DayTwo.PartTwo do
  alias AoC.DayTwo.Common

  def main() do
    "lib/day2/input.txt"
    |> Common.read_input()
    |> find_correct_boxes()

    receive do
      {x, y} -> get_common_characters(x, y)
    end
  end

  defp find_correct_boxes(box_ids) do
    for x <- box_ids do
      for y <- box_ids do
        zipped = Enum.zip(String.graphemes(x), String.graphemes(y))

        differences =
          Enum.reduce(zipped, 0, fn {z1, z2}, acc -> if z1 == z2, do: acc, else: acc + 1 end)

        if(differences == 1) do
          send(self(), {x, y})
        end
      end
    end
  end

  defp get_common_characters(x, y) do
    Enum.zip(String.graphemes(x), String.graphemes(y))
    |> Enum.reduce("", fn {x1, x2}, acc -> if x1 == x2, do: acc <> x1, else: acc end)
  end
end
