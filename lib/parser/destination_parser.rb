require_relative 'base_parser'

class DestinationParser < BaseParser
  def parse
    hashify_nodes
  end

  private

  def hashify_nodes
    @nodes = @handler.destination_nodes.reduce({}) do |acc, node|
      acc[node[:atlas_id]] = node
      acc
    end
  end
end
