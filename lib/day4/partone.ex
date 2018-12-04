defmodule AoC.DayFour.PartOne do
  alias AoC.DayFour.Common

  def main() do
    "lib/day4/input.txt"
    |> Common.read_input()
    |> Common.calculate_guard_minutes()
    |> get_sleepiest_guard()
    |> get_sleepiest_minute()
    |> calculate_result()
  end

  defp calculate_result({guard, minute}) do
    guard * minute
  end

  defp get_sleepiest_minute(map) do
    {_, {guard, minutes}} = map

    {sleepiest_minute, _} =
      # Format: {guard, minutes_slept}
      Enum.reduce(minutes, {0, 0}, fn {current_minute, count}, {highest_minute, highest_count} ->
        if count > highest_count,
          do: {current_minute, count},
          else: {highest_minute, highest_count}
      end)

    {String.to_integer(guard), sleepiest_minute}
  end

  defp get_sleepiest_guard(map) do
    # Format: {minutes_slept, {guard, minutes}}
    Enum.reduce(map, {0, {0, %{}}}, fn {guard, minutes}, sleepiest_guard ->
      minutes_slept = Enum.reduce(minutes, 0, fn {_, count}, acc -> acc + count end)
      {current_sleep_minutes, _} = sleepiest_guard

      if minutes_slept > current_sleep_minutes,
        do: {minutes_slept, {guard, minutes}},
        else: sleepiest_guard
    end)
  end
end
