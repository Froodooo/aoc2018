defmodule AoC.DayThree.Common do
  alias AoC.DayThree.Claim

  def read_input(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
  end

  def get_fabric(claims) do
    Enum.reduce(claims, %{}, fn claim, map ->
      Enum.reduce((claim.left + 1)..(claim.left + claim.columns), map, fn x, map ->
        Enum.reduce((claim.top + 1)..(claim.top + claim.rows), map, fn y, map ->
          Map.update(map, {x, y}, 1, &(&1 + 1))
        end)
      end)
    end)
  end

  def parse_into_structs(input) do
    input
    |> Enum.map(&parse_struct/1)
  end

  defp parse_struct(input) do
    [id, rest] = String.split(input, "@")
    [location, dimension] = String.split(rest, ":")
    [left, top] = String.split(location, ",")
    [columns, rows] = String.split(dimension, "x")

    id =
      id
      |> String.trim("#")
      |> to_integer()

    left =
      left
      |> to_integer()

    top =
      top
      |> to_integer()

    columns =
      columns
      |> to_integer()

    rows =
      rows
      |> to_integer()

    %Claim{id: id, left: left, top: top, columns: columns, rows: rows}
  end

  defp to_integer(input) do
    input
    |> String.trim()
    |> String.to_integer()
  end
end
