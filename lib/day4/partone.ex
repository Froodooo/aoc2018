defmodule AoC.DayFour.PartOne do
  alias AoC.DayFour.Common

  def main() do
    # TODO read input
    # TODO sort input by date and time
    # TODO create list of lists, inner list being the info for one guard during one night
    # TODO iterate list of lists, processing info for one guard during one night, putting info in map entry: 
    # {
    #   guardid, 
    #   day,
    #   [{minute: state}],
    #   total_asleep,
    #   total_awake
    # }
    # TODO iterate map entries, find the guard who is asleep the most

    "lib/day4/input.txt"
    |> Common.read_input()
  end
end
