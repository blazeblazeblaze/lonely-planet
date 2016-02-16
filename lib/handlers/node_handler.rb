class NodeHandler
  attr_reader :nodes, :stack
  ATTRS_TO_PARSE = [:atlas_node_id]

  def initialize
    @nodes  = []
    @stack  = []
  end

  def attr(name, value)
    return unless ATTRS_TO_PARSE.include? name

    append(value)
  end

  def start_element(name)
    case name
    when :taxonomies
      new_element([])
    when :node
      new_element({})
    end
  end

  def new_element(el)
    append(el)
    @stack.push(el)
  end

  def end_element(name)
    return unless name == :node
    @stack.pop
  end

  def append(value)
    if last_node.is_a?(Array)
      last_node.push(value)
    elsif last_node.is_a?(NilClass)
      @nodes = value
    end
  end

  def last_node
    @stack.last
  end
end
