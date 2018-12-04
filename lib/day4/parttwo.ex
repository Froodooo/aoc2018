defmodule AoC.DayFour.PartTwo do
  alias AoC.DayFour.Common

  def main() do
    "lib/day4/input.txt"
    |> Common.read_input()
    |> calculate_guard_minutes(%{}, "", 0)
    |> get_sleepiest_guard()
  end

  defp get_sleepiest_guard(map) do
    Enum.reduce(map, {0, 0, 0}, fn {guard, minutes}, sleepiest_guard -> 
      {minute, count} = Enum.reduce(minutes, {0, 0}, fn {minute, count}, {current_minute, highest_count} -> if count > highest_count, do: {minute, count}, else: {current_minute, highest_count} end)
      {current_guard, current_minutes, current_count} = sleepiest_guard
      if count > current_count, do: {guard, minute, count}, else: sleepiest_guard 
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
