require 'forwardable'

class Destination
  extend Forwardable
  attr_reader :destination_item, :destination_list

  def_delegators :@destination_item, :title, :atlas_id, :history, :overview

  def initialize(destination_item, destination_list)
    @destination_item = destination_item
    @destination_list = destination_list
  end

  def parent
    destination_list.parent_for(destination_item.atlas_id)
  end

  def children
    destination_list.children_for(destination_item.atlas_id)
  end
end
