class DestinationHandler
  attr_reader :nodes, :stack
  ATTRS_TO_PARSE = [:title, :atlas_id]

 def initialize
    @key   = nil
    @nodes = {}
    @stack = []
  end

  def cdata(str)
    append(str)
  end

  def attr(name, value)
    return unless ATTRS_TO_PARSE.include? name

    @key = name
    append(value)
  end

  def start_element(name)
    case name
    when :destination
      new_element({})
    when :destinations
      new_element([])
    else
      @key = name
    end
  end

  def new_element(el)
    append(el)
    @stack.push(el)
  end

  def end_element(name)
    return unless :destination == name
    @stack.pop
  end

  def append(value)
    if last_node.is_a?(Hash)
      last_node[@key] = value
      @key = nil
    elsif last_node.is_a?(Array)
      last_node.push(value)
    elsif last_node.nil?
      @nodes = value
    end
  end

  def last_node
    @stack.last
  end
end
