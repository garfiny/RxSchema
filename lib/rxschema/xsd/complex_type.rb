class RxSchema::XSD::ComplexType < RxSchema::XSD::XMLElement

  attr_accessor :type_name

  def initialize
    @type_name = nil
  end

  def register(schema, parent)

  end
end
