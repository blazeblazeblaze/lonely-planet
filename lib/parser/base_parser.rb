require 'ox'

class BaseParser
  attr_reader :nodes

  def initialize(xml:, handler:)
    @io      = xml
    @handler = handler
    @nodes   = {}

    parse_on_init
  end

  def parse
    raise NotImplementedError
  end

  private

  def parse_on_init
    Ox.sax_parse(@handler, @io)
  end
end
