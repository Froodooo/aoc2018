defmodule AoC.DayTwo.Common do
  def read_input(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
  end
end
