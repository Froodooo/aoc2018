defmodule AoC.DaySix.Common do
  alias AoC.DaySix.{Coordinate, Field}

  def read_input(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.with_index()
    |> Enum.map_reduce(%Field{}, fn {line, index}, field -> parse_input(line, index, field) end)
  end

  defp parse_input(line, index, field) do
    coordinate = get_coordinate(line, index)
    field = get_field(coordinate, field)
    {coordinate, field}
  end

  defp get_coordinate(line, index) do
    [x, y] = String.split(line, ",")
    x = get_integer(x)
    y = get_integer(y)
    %Coordinate{id: index, x: x, y: y}
  end

  defp get_integer(string) do
    string
    |> String.trim()
    |> String.to_integer()
  end

  defp get_field(coordinate, field) do
    %Field{
      min_x: min(coordinate.x, field.min_x),
      min_y: min(coordinate.y, field.min_y),
      max_x: max(coordinate.x, field.max_x),
      max_y: max(coordinate.y, field.max_y)
    }
  end
end
