defmodule AoC.DaySeven.Worker do
  alias AoC.DaySeven.{Prerequisite, Worker}

  defstruct step: "", remaining: 0

  def spawn(amount) do
    Enum.reduce(0..(amount - 1), [], fn _x, acc ->
      [%Worker{} | acc]
    end)
  end

  def iterate(workers, steps_map, head_map, order) do
    Enum.reduce(workers, {[], steps_map, head_map, order}, fn x, {w, s, h, o} ->
      cond do
        x.remaining > 1 ->
          {[%Worker{step: x.step, remaining: x.remaining - 1} | w], s, h, o}

        true ->
          # Removes the next_step as prerequisite in both the 
          # steps_map and the head_map.
          s = remove_prerequisite(s, x.step)
          h = remove_prerequisite(h, x.step)

          # Removes the next_step from the steps_map and the head_map.
          #s = remove_next_step(s, x.step)
          #h = remove_next_step(h, x.step)

          o = [x.step | o]

          {[%Worker{} | w], s, h, o}
      end
    end)
  end

  def available(workers) do
    Enum.reduce(workers, 0, fn x, acc ->
      cond do
        x.remaining == 0 -> acc + 1 
        true -> acc 
      end
    end)
  end

  def assign(step, workers) do
    empty_worker = find_first_empty_worker(workers)
    <<s::utf8>> = step
    remaining = s - 4

    Enum.map(Enum.with_index(workers), fn {x, i} ->
      case i do
        ^empty_worker -> %Worker{step: step, remaining: remaining}
        _ -> x
      end
    end)
  end

  defp find_first_empty_worker(workers) do
    Enum.reduce_while(Enum.with_index(workers), 0, fn {x, i}, _acc ->
      cond do
        x.remaining == 0 -> {:halt, i}
        true -> {:cont, 0}
      end
    end)
  end

  def remove_prerequisite(steps_map, next_step) do
    Enum.map(steps_map, fn {step, prerequisite} ->
      list = prerequisite.list

      list =
        Enum.filter(list, fn prerequisite_step ->
          prerequisite_step != next_step
        end)

      {step, %Prerequisite{list: list, count: length(list)}}
    end)
    |> Map.new()
  end

  def remove_next_step(map, next_step) do
    Enum.filter(map, fn {step, _} -> step != next_step end)
    |> Map.new()
  end
end
