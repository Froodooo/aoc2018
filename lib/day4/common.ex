defmodule AoC.DayFour.Common do
  def read_input(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(fn x ->
      [datetime, log] = Regex.run(~r/\[(.*)\] (.*)/, x, capture: :all_but_first)
      {:ok, datetime} = Timex.parse(datetime, "{YYYY}-{M}-{D} {h24}:{m}")
        %{datetime: datetime, log: log}
    end)
    |> Enum.to_list()
    |> Enum.sort_by(fn x -> x.datetime end)
  end
end
