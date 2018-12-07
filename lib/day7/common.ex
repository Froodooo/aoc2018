defmodule AoC.DaySeven.Common do
  def read_input(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.map(fn line ->
      [head, tail] =
        Regex.run(~r/^Step ([A-Z]{1}).*step ([A-Z]{1}).*$/, line, capture: :all_but_first)

      %{prerequisite: head, step: tail}
    end)
    |> Enum.to_list()
  end
end
