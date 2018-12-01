defmodule DayOne do
  def main() do
    read_input()
    |> calculate_sum()
    |> IO.puts()
  end

  defp read_input() do
    File.stream!("input.txt")
    |> Stream.map(&String.trim/1)
    |> Stream.filter(fn x -> x != "" end)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
  end

  defp calculate_sum(numbers) do
    Enum.sum(numbers)
  end
end

DayOne.main()
