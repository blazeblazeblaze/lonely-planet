require_relative 'base_parser'

class NodeParser < BaseParser
  def parse
    hashify_nodes([@handler.nodes])
  end

  private

  def hashify_nodes(node_arr=[], parent=nil)
    node_arr.each do |node|
      first, *rest  = node

      @nodes[first] = {
        parent:  parent,
        children: rest.map(&:first)
      }

      hashify_nodes(rest, first)
    end
  end
end
