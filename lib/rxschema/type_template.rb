class RxSchema::TypeTemplate

  def initialize(type_descriptor)
    @type_descriptor = type_descriptor
    @attributes = []
    @restrictions = {}
  end

  def add_attribute(attribute_name, type_descriptor)
  end

  def add_restriction
  end

  def class_name
  end

  # def xsd_type?
  #   prefix, name = type_name.split(":")
  #   prefix == @schema.prefix
  # end

  # def self_defined_type?
  #   !self.xsd_type?
  # end

  # def set_type_name
  #   self.type_name = self.respond_to?(:type) ? self.type : self.name + "Type"
  # end
end
