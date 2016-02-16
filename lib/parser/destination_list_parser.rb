require_relative 'destination_parser'
require 'sax-machine'
class DestinationListParser
  include SAXMachine
  elements :destination, as: :destinations, lazy: true, class: DestinationParser
end

