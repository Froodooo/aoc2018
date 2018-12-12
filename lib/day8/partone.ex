defmodule AoC.DayEight.PartOne do
  alias AoC.DayEight.{Common, Node}

  def main() do
    "lib/day8/input.txt"
    |> Common.read_input()
    |> parse()
    |> elem(0)
    |> sum_metadata()
    |> List.flatten()
    |> Enum.sum()
  end

  defp sum_metadata(node) do
    sum_metadata = Enum.flat_map(node.children, &sum_metadata/1)
    metadata = Tuple.to_list(node.metadata) 
    [metadata | sum_metadata]
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
      node = Map.update(node, :children, [], &[child | &1])
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
