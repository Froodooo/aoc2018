defmodule AoC.DaySix.PartOne do
  alias AoC.DaySix.{Common}

  def main() do
    "lib/day6/input.txt"
    |> Common.read_input()

    # TODO get manhattan distance from all field coordinates to all input coordinates
    # TODO result: 
    # %{field_coordinate => 
    #   %{
    #     input_coordinate1: distance, 
    #     input_coordinate2: distance,
    #     ...
    #    } 
    #  }
    # TODO iterate over result and determine closest input coordinate per field coordinate
    # TODO result:
    # %{field_coordinate => input_coordinate, ...}
    # TODO: return number of most occurring input coordinate as largest area 
  end
end
