defmodule AoC.DayFive.Common do
  def read_input(path) do
    path
    |> File.read!()
    |> String.trim()
    |> String.graphemes()
  end
end
