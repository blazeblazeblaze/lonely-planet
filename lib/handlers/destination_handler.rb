class DestinationHandler
  attr_reader :destination_nodes, :destination_stack

 def initialize
    @key               = nil
    @destination_nodes = nil
    @destination_stack = []
  end

  def cdata(str)
    append(str)
  end

  def attr(name, value)
    return unless [:title, :atlas_id].include? name

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
    @destination_stack.push(el)
  end

  def end_element(name)
    return unless :destination == name
    @destination_stack.pop
  end

  def append(value)
    last = @destination_stack.last

    if last.is_a?(Hash)
      last[@key] = value
      @key = nil
    elsif last.is_a?(Array)
      last.push(value)
    elsif last.nil?
      @destination_nodes = value
    end
  end
end
