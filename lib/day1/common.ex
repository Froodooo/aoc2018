defmodule AoC.DayOne.Common do
  def read_input(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Stream.filter(fn x -> x != "" end)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
  end
end
