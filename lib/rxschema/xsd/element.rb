class RxSchema::XSD::Element < RxSchema::XSD::XMLElement

  attr_accessor :schema

  def initialize
    @schema = nil
    super
  end

  def self.new_element(schema, prefix = nil, xmlns = {}, attrs = [])
    elem = self.init_xml_element(prefix, xmlns, attrs)
    elem.schema = schema
    elem
  end

  def add_xmlns(prefix, uri)
    @schema.add_xmlns(prefix, uri)
  end

  def close_element
  end
end
