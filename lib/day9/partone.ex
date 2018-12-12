defmodule AoC.DayNine.PartOne do
  alias AoC.DayNine.{Circle, Marble}

  @players 424
  @special_marble 23
  @points_last_marble 71144

  def main() do
    circle = prepare()
    play(circle)
  end

  defp play(%{round: round} = circle) when rem(round, 23) == 0 do
    circle
  end

  defp play(circle) do
    marble_previous = Circle.get(circle, circle.current, :next)
    marble_next = Circle.get(circle, marble_previous, :next)

    circle
    |> Circle.put(circle.round, %Marble{previous: marble_previous, next: marble_next})
    |> Circle.next_round()
    |> play()
  end

  defp prepare() do
    Circle.new()
    |> Circle.put(0, %Marble{previous: 0, next: 0})
    |> Circle.next_round()
  end
end
