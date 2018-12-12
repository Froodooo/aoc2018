defmodule AoC.DaySeven.PartTwo do
  alias AoC.DaySeven.{Common, Prerequisite, Worker}

  @amount_of_workers 5

  def main() do
    "lib/day7/input.txt"
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

  def get_steps_order(steps_map, head_map \\ %{}, order \\ [], workers \\ [], seconds \\ 0)

  def get_steps_order(steps_map, _head_map, order, workers, seconds) when steps_map == %{} do
    IO.inspect workers
    result =
      order
      |> Enum.reverse()
      |> Enum.join()

    {seconds, result}
  end

  def get_steps_order(steps_map, head_map, order, _workers, _seconds) when head_map == %{} do
    # Fills head_map when there are no entries yet,
    # or takes the current one.
    head_map =
      case Enum.count(head_map) do
        0 -> get_next_available_steps(steps_map)
        _ -> head_map
      end

    workers = Worker.spawn(@amount_of_workers)

    get_steps_order(steps_map, head_map, order, workers)
  end

  def get_steps_order(steps_map, head_map, order, workers, seconds) do
    {workers, steps_map, head_map, order} = Worker.iterate(workers, steps_map, head_map, order)
    available = Worker.available(workers)

    cond do
      available == 0 ->
        get_steps_order(steps_map, head_map, order, workers, seconds + 1)

      !has_empty_prerequisites?(head_map) ->
        get_steps_order(steps_map, head_map, order, workers, seconds + 1)

      true ->
        # Gets the step which doesn't have prerequisites anymore
        # and occurs the first in the alphabet.
        {steps_map, head_map, order, workers} =
          cond do
            available > 1 ->
              Enum.reduce(0..(available - 1), {steps_map, head_map, order, workers}, fn _,
                                                                                        {s, h, o,
                                                                                         w} ->
                add_step(s, h, o, w)
              end)

            true ->
              add_step(steps_map, head_map, order, workers)
          end

        # Continue with the next iteration.
        get_steps_order(steps_map, head_map, order, workers, seconds + 1)
    end
  end

  defp add_step(steps_map, head_map, order, workers) do
    next_step = get_step_to_append(head_map)
    IO.inspect next_step

    case next_step do
      nil ->
        {steps_map, head_map, order, workers}

      _ ->
        steps_map = Worker.remove_next_step(steps_map, next_step)
        head_map = Worker.remove_next_step(head_map, next_step)

        workers = Worker.assign(next_step, workers)

        # Adds steps for which the next_step is a prerequisite
        # (so possible new steps for future iterations).
        head_map = add_new_steps(steps_map, head_map, next_step)

        # Adds the next_step to the current order.
        #order = [next_step | order]

        {steps_map, head_map, order, workers}
    end
  end

  defp has_empty_prerequisites?(head_map) do
    Enum.reduce_while(head_map, false, fn {_, prerequisite}, _acc ->
      cond do
        Enum.count(prerequisite.list) == 0 -> {:halt, true}
        true -> {:cont, false}
      end
    end)
  end

  defp get_next_available_steps(map) do
    Enum.filter(map, fn {_, prerequisite} -> prerequisite.count == 0 end)
    |> Map.new()
  end

  defp get_step_to_append(head_map) do
    steps =
      head_map
      |> get_next_available_steps()
      |> Enum.map(fn {k, _} -> k end)

    case Enum.count(steps) do
      0 -> nil
      _ -> Enum.min(steps)
    end
  end

  defp add_new_steps(steps_map, head_map, next_step) do
    new_head_map_items =
      Enum.filter(steps_map, fn {_, prerequisite} ->
        Enum.member?(prerequisite.list, next_step)
      end)
      |> Map.new()

    Map.merge(head_map, new_head_map_items)
  end
end
