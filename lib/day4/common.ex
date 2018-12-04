defmodule AoC.DayFour.Common do
  @line_regex ~r/\[(.*)\] (.*)/
  @date_format "{YYYY}-{M}-{D} {h24}:{m}"

  def read_input(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> Enum.sort()
    |> Enum.map(fn x ->
      [datetime, log] = Regex.run(@line_regex, x, capture: :all_but_first)
      {:ok, datetime} = Timex.parse(datetime, @date_format)
      %{datetime: datetime, log: log}
    end)
  end

  def calculate_guard_minutes(input, map \\ %{}, current_guard \\ "", last_minute \\ 0)

  def calculate_guard_minutes([line | rest], map, current_guard, last_minute) do
    case line.log do
      "falls asleep" ->
        calculate_guard_minutes(rest, map, current_guard, line.datetime.minute)

      "wakes up" ->
        map = Map.put_new(map, current_guard, %{})
        guard = Map.get(map, current_guard)

        guard =
          Enum.reduce(last_minute..(line.datetime.minute - 1), guard, fn x, acc ->
            Map.update(acc, x, 1, &(&1 + 1))
          end)

        map = Map.put(map, current_guard, guard)
        calculate_guard_minutes(rest, map, current_guard, line.datetime.minute)

      _ ->
        [new_guard] =
          Regex.run(~r/^Guard #(\d+) begins shift$/, line.log, capture: :all_but_first)

        calculate_guard_minutes(rest, map, new_guard, 0)
    end
  end

  def calculate_guard_minutes([], map, _current_guard, _last_minute) do
    map
  end
end
