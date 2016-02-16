require_relative 'destination'

class DestinationList
  attr_reader :raw_destinations, :raw_locations

  def initialize(raw_destinations, raw_locations)
    @raw_destinations = raw_destinations
    @raw_locations    = raw_locations
  end

  def destinations
    @_destinations ||= raw_destinations.reduce({}) do |acc, raw_destination|
      acc[raw_destination.atlas_id] = Destination.new(raw_destination, self)
      acc
    end
  end

  def parent_for(id)
    parent_id = raw_locations.dig(id, :parent)
    return unless parent_id
    destinations[parent_id]
  end

  def children_for(id)
    children_ids = raw_locations.dig(id, :children)
    return [] unless children_ids

    children_ids.map do |child_id|
      destinations[child_id]
    end
  end

  def each(&block)
    destinations.each(&block)
  end
end
