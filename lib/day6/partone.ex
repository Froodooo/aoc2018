defmodule AoC.DaySix.PartOne do
  alias AoC.DaySix.{Coordinate, Common}

  def main() do
    "lib/day6/input.txt"
    |> Common.read_input()
    |> get_distance()
    |> Enum.filter(fn {_k, v} -> v != nil end)
    |> Enum.reduce(%{}, fn {_, {[c], _}}, acc ->
      Map.update(acc, c.id, 1, &(&1 + 1))
    end)
    |> Enum.reduce(0, fn {_, v}, acc -> max(v, acc) end)
  end

  defp get_distance({coordinates, field}) do
    Enum.reduce(field.min_x..field.max_x, %{}, fn x, acc ->
      Enum.reduce(field.min_y..field.max_y, acc, fn y, acc ->
        get_field_distances(x, y, coordinates, field, acc)
      end)
    end)
  end

  defp get_field_distances(x, y, coordinates, field, acc) do
    field_coordinate = %Coordinate{x: x, y: y}
    max_distance = get_max_distance(field)

    {result, distance} =
      Enum.reduce(coordinates, {[], max_distance}, fn input_coordinate, {result, distance} ->
        get_distance_to_coordinate(input_coordinate, field_coordinate, result, distance)
      end)

    result_distance =
      case length(result) do
        1 -> {result, distance}
        _ -> nil
      end

    Map.put(acc, {x, y}, result_distance)
  end

  defp get_max_distance(field) do
    get_manhattan_distance(%Coordinate{x: field.min_x, y: field.min_y}, %Coordinate{
      x: field.max_x,
      y: field.max_y
    })
  end

  defp get_distance_to_coordinate(input_coordinate, field_coordinate, result, distance) do
    distance_total = get_manhattan_distance(input_coordinate, field_coordinate)

    cond do
      distance_total == distance -> {[input_coordinate | result], distance}
      distance_total < distance -> {[input_coordinate], distance_total}
      true -> {result, distance}
    end
  end

  defp get_manhattan_distance(c1, c2) do
    abs(c1.x - c2.x) + abs(c1.y - c2.y)
  end
end
