class RxSchema::ElementStack

  def initialize
    @stack = Array.new
  end

  def push(elem)
    @stack.push elem
  end

  def pop
    @stack.pop
  end

  def empty?
    @stack.empty?
  end

  def retro(element_tag_name)
    matched_index = -1
    @stack.reverse_each.each_with_index do |e, index|
      if symbolize_name(e.class.name.demodulize) == symbolize_name(element_tag_name)
        matched_index = index + 1
        break
      end
    end
    matched_index < 0 ? [] : @stack.slice!(@stack.length - matched_index, @stack.length)
  end

  def symbolize_name(name)
    name.underscore.to_sym
  end
end
