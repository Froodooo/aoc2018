defmodule DayOne do
  def main() do
    read_input()
    |> calculate_result()
    |> IO.puts()
  end

  def read_input() do
    File.stream!("input.txt")
    |> Stream.map(&String.trim/1)
    |> Stream.filter(fn x -> x != "" end)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
  end

  def calculate_result(numbers, frequencies \\ [], base \\ 0, index \\ 0)

  def calculate_result(numbers, frequencies, base, index) when index == length(numbers) do
    calculate_result(numbers, frequencies, base, 0)
  end

  def calculate_result(numbers, frequencies, base, index) do
    base = base + Enum.at(numbers, index)
    if (Enum.member?(frequencies, base)) do
      base
    else
      frequencies = [base | frequencies]
      calculate_result(numbers, frequencies, base, index + 1)
    end
  end
end

DayOne.main()
