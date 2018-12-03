defmodule AoC.DayThree.PartTwo do
  alias AoC.DayThree.Common

  def main() do
    claims =
      "lib/day3/input.txt"
      |> Common.read_input()
      |> Common.parse_into_structs()

    fabric = Common.get_fabric(claims)
    find_non_overlapping_claim(fabric, claims)
  end

  defp find_non_overlapping_claim(fabric, claims) do
    Enum.reduce_while(claims, false, fn claim, _ ->
      result_columns =
        Enum.reduce_while((claim.left + 1)..(claim.left + claim.columns), false, fn x, _ ->
          result_rows =
            Enum.reduce_while((claim.top + 1)..(claim.top + claim.rows), false, fn y, _ ->
              if Map.get(fabric, {x, y}) > 1, do: {:halt, false}, else: {:cont, true}
            end)

          if result_rows, do: {:cont, true}, else: {:halt, false}
        end)

      if result_columns, do: {:halt, claim.id}, else: {:cont, false}
    end)
  end
end
