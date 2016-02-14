require './lib/parser/node_parser'
require './lib/parser/destination_parser'

require './lib/handlers/node_handler'
require './lib/handlers/destination_handler'

class AppData
  attr_reader :threads, :destinations, :taxonomies

  def initialize(options)
    @tax_file = File.open(options.taxonomy_path)
    @des_file = File.open(options.destinations_path)

    set_defaults
  end

  def load
    threads << taxonomies_nodes
    threads << destinations_nodes

    threads.each(&:join)
  end

  private

  def taxonomies_nodes
    Thread.new do
      parser = NodeParser.new(xml: @tax_file, handler: NodeHandler.new)
      parser.parse

      @taxonomies = parser.nodes
    end
  end

  def destinations_nodes
    Thread.new do
      parser = DestinationParser.new(xml: @des_file, handler: DestinationHandler.new)
      parser.parse

      @destinations = parser.nodes
    end
  end

  def set_defaults
    @threads      = []
    @taxonomies   = {}
    @destinations = {}
  end
end
