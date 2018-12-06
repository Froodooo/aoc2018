defmodule AoC.DaySix.PartTwo do
  alias AoC.DaySix.{Common}

  @max_region_size 10000

  def main() do
    "lib/day6/input.txt"
    |> Common.read_input()
    |> get_distance()
    |> Enum.filter(fn {_k, v} -> v < @max_region_size end)
    |> Enum.count()
  end

  defp get_distance({coordinates, field}) do
    Enum.reduce(field.min_x..field.max_x, %{}, fn x, acc ->
      Enum.reduce(field.min_y..field.max_y, acc, fn y, acc ->
        result =
          Enum.reduce(coordinates, 0, fn coordinate, result ->
            get_total_distance(coordinate, x, y, result)
          end)

        Map.put(acc, {x, y}, result)
      end)
    end)
  end

  defp get_total_distance(coordinate, x, y, result) do
    result + abs(coordinate.x - x) + abs(coordinate.y - y)
  end
end
