defmodule AoC.DaySeven.PartOne do
  alias AoC.DaySeven.{Common, Prerequisite}

  def main() do
    "lib/day7/input_test.txt"
    |> Common.read_input()
    |> get_steps_map()
    |> get_steps_order()
  end

  defp get_steps_map(instructions) do
    instructions
    |> Enum.reduce(%{}, fn instruction, steps_map ->
      steps_map
      |> Map.put_new(instruction.prerequisite, %Prerequisite{})
      |> Map.update(
        instruction.step,
        %Prerequisite{list: [instruction.prerequisite], count: 1},
        fn prerequisite ->
          %Prerequisite{
            list: [instruction.prerequisite | prerequisite.list],
            count: prerequisite.count + 1
          }
        end
      )
    end)
  end

  def get_steps_order(steps_map, head_map \\ %{}, order \\ [])

  #def get_steps_order(%{}, %{}, order) do
  #  Enum.reverse(order)
  #end

  def get_steps_order(steps_map, head_map, order) do
    IO.inspect(order)
    head_map =
      case Enum.count(head_map) do
        0 -> get_next_available_steps(steps_map)
        _ -> head_map
      end

    next_step = get_step_to_append(head_map)
    steps_map = Enum.filter(steps_map, fn {step, _} -> step != next_step end)
                |> Map.new()
    head_map = Enum.filter(head_map, fn {step, _} -> step != next_step end)
               |> Map.new()
    head_map = add_new_steps(steps_map, head_map, next_step)
    order = [next_step | order]
    get_steps_order(steps_map, head_map, order)
  end

  defp get_next_available_steps(steps_map) do
    Enum.filter(steps_map, fn {_, prerequisite} -> prerequisite.count == 0 end)
    |> Map.new()
  end

  defp get_step_to_append(head_map) do
    steps = Enum.map(head_map, fn {k, _} -> k end)
    Enum.min(steps)
  end

  defp add_new_steps(steps_map, head_map, next_step) do
    new_head_map_items =
      Enum.filter(steps_map, fn {_, prerequisite} -> Enum.member?(prerequisite.list, next_step) end)
      |> Map.new()

    Map.merge(head_map, new_head_map_items)
  end
end
