class RxSchema::XSD::XMLAttribute

  attr_accessor :raw_name, :name, :prefix, :value

  def initialize(raw_name, value, prefix)
    @raw_name, @prefix, @value = raw_name, prefix, value
    @name = @raw_name.underscore
  end
end
