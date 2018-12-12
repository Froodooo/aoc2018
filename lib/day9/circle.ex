defmodule AoC.DayNine.Circle do
  alias AoC.DayNine.Circle

  defstruct current: 0, round: 0, previous: 0, next: 0 

  def new() do
    %Circle{}
  end

  def put(circle, id, marble) do
    circle
    |> Map.put(id, marble)
    |> Map.put(:current, id)
    |> Map.update(marble.previous, marble, fn x -> %{x | next: id} end)
    |> Map.update(marble.next, marble, fn x -> %{x | previous: id} end)
  end

  def get(circle, marble_id, direction) do
    circle
    |> Map.get(marble_id)
    |> Map.get(direction)
  end

  def next_round(circle) do
    %{circle | round: circle.round + 1}
  end
end
