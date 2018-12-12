defmodule AoC.DayEight.Common do
  def read_input(path) do
    path
    |> File.read!()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end
