require 'sax-machine'

class DestinationParser
  include SAXMachine

  attribute :atlas_id
  attribute :title

  element :overview
  elements :history, as: :history
end
