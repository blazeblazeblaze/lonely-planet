class Destination
  attr_reader :destination_item, :destination_list

  def initialize(destination_item, destination_list)
    @destination_item = destination_item
    @destination_list = destination_list
  end

  def parent
    destination_list.parent_for(atlas_id)
  end

  def children
    destination_list.children_for(atlas_id)
  end

  def title
    destination_item[:title]
  end

  def atlas_id
    destination_item[:atlas_id]
  end

  def history
    destination_item[:history]
  end
end
