defmodule AoC.DayFour.PartOne do
  alias AoC.DayFour.Common

  def main() do
    "lib/day4/input.txt"
    |> Common.read_input()
    |> calculate_guard_minutes(%{}, "", 0)
    |> get_sleepiest_guard()
    |> get_sleepiest_minute()
  end

  defp get_sleepiest_minute(map) do
    {total_minutes, {guard, minutes}} = map
    {sleepiest_minute, count} = Enum.reduce(minutes, {0, 0}, fn {current_minute, count}, {highest_minute, highest_count} ->
      if count > highest_count, do: {current_minute, count}, else: {highest_minute, highest_count}
    end)
    {guard, sleepiest_minute, count}
  end

  defp get_sleepiest_guard(map) do
    Enum.reduce(map, {0, {0, %{}}}, fn {guard, minutes}, sleepiest_guard -> 
      sleep_minutes = Enum.reduce(minutes, 0, fn {minute, count}, acc -> acc + count end)
      {current_sleep_minutes, _} = sleepiest_guard
      if sleep_minutes > current_sleep_minutes, do: {sleep_minutes, {guard, minutes}}, else: sleepiest_guard
    end)
  end

  defp calculate_guard_minutes([], map, _current_guard, _last_minute) do
    map
  end

  defp calculate_guard_minutes([head | rest], map, current_guard, last_minute) do
    case head.log do
      "falls asleep" ->
        calculate_guard_minutes(rest, map, current_guard, head.datetime.minute)

      "wakes up" ->
        map = Map.put_new(map, current_guard, %{})
        guard = Map.get(map, current_guard)

        guard =
          Enum.reduce(last_minute..(head.datetime.minute - 1), guard, fn x, acc ->
            Map.update(acc, x, 1, &(&1 + 1))
          end)

        map = Map.put(map, current_guard, guard)
        calculate_guard_minutes(rest, map, current_guard, head.datetime.minute)

      _ ->
        [new_guard] =
          Regex.run(~r/^Guard #(\d+) begins shift$/, head.log, capture: :all_but_first)

        calculate_guard_minutes(rest, map, new_guard, 0)
    end
  end
end
