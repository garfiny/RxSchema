class RxSchema::TypeRegister

  def initialize
    @type_elements = {}
  end

  def register_type(type_name, element)
    @type_elements[type_name] = element
  end

  def register_complex_type(type_name)
  end

  def register_simple_type(type_name)
  end
end
