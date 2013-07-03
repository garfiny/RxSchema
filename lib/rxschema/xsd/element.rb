class RxSchema::XSD::Element < RxSchema::XSD::XMLElement

  attr_accessor :schema, :type_name

  def initialize
    @schema = nil
    @type_name = 'not_registered'
    super
  end

  def self.new_element(schema, prefix = nil, xmlns = {}, attrs = [])
    elem = self.init_xml_element(prefix, xmlns, attrs)
    elem.schema = schema
    elem.set_type_name
    elem
  end

  def xsd_type?
    prefix, name = type_name.split(":")
    prefix == @schema.prefix
  end

  def self_defined_type?
    !self.xsd_type?
  end

  def set_type_name
    self.type_name = self.respond_to?(:type) ? self.type : self.name + "Type"
  end

  def add_xmlns(prefix, uri)
    @schema.add_xmlns(prefix, uri)
  end

  def close_element
  end
end
