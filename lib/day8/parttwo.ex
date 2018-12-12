defmodule AoC.DayEight.PartTwo do
  alias AoC.DayEight.{Common, Node}

  def main() do
    "lib/day8/input.txt"
    |> Common.read_input()
    |> parse()
    |> elem(0)
    |> IO.inspect
    |> get_values()
    |> Enum.sum()
  end

  defp get_values(%Node{children_quantity: 0} = node) do
    node.metadata
    |> Tuple.to_list()
    |> Enum.sum()
    |> List.wrap()
  end

  defp get_values(node) do
    Enum.flat_map(Tuple.to_list(node.metadata), fn i ->
      IO.inspect i
      case Enum.at([nil | node.children], i) do
        nil -> []
        child -> 
          get_values(child)
      end
    end)
  end

  defp parse([children_quantity, metadata_quantity | tail]) do
    {%Node{children_quantity: children_quantity, metadata_quantity: metadata_quantity}, tail}
    |> parse_children()
    |> parse_metadata()
  end

  defp parse_children({node, tail}) do
    if length(node.children) == node.children_quantity do
      {node, tail}
    else
      {child, rest} = parse(tail)
      node = Map.update(node, :children, [], &(&1 ++ [child]))
      parse_children({node, rest})
    end
  end

  defp parse_metadata({node, tail}) do
    {metadata, rest} = Enum.split(tail, node.metadata_quantity)
    metadata = List.to_tuple(metadata)
    node = %{node | metadata: metadata}
    {node, rest}
  end
end
