defmodule AoC.DayFour.PartTwo do
  alias AoC.DayFour.Common

  def main() do
    "lib/day4/input.txt"
    |> Common.read_input()
    |> Common.calculate_guard_minutes()
    |> get_sleepiest_guard()
    |> calculate_result()
  end

  defp calculate_result({guard, minute}) do
    guard * minute
  end

  defp get_sleepiest_guard(map) do
    # Format: {guard, minute, count}
    {guard, minute, _} =
      Enum.reduce(map, {0, 0, 0}, fn {guard, minutes}, sleepiest_guard ->
        # Format: {minute, count}
        {minute, count} =
          Enum.reduce(minutes, {0, 0}, fn {minute, count}, {current_minute, highest_count} ->
            if count > highest_count, do: {minute, count}, else: {current_minute, highest_count}
          end)

        {_, _, current_count} = sleepiest_guard

        if count > current_count,
          do: {String.to_integer(guard), minute, count},
          else: sleepiest_guard
      end)

    {guard, minute}
  end
end
