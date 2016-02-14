class NodeHandler
  attr_reader :location_nodes, :node_stack

  def initialize
    @location_nodes  = []
    @node_stack      = []
  end

  def attr(name, value)
    return unless name == :atlas_node_id

    append(value)
  end

  def start_element(name)
    return unless name == :node

    new_elem = Array.new
    append(new_elem)
    @node_stack.push(new_elem)
  end

  def end_element(name)
    return unless name == :node
    @node_stack.pop
  end

  def append(value)
    if last_node.is_a?(Array)
      last_node.push(value)
    elsif last_node.is_a?(NilClass)
      @location_nodes = value
    end
  end

  def last_node
    @node_stack.last
  end
end
