class RxSchema::XSD::Element < RxSchema::XSD::XMLElement

  attr_accessor :schema

  def initialize
    @schema = nil
    @namespaces = {}
    @parent = nil
    super
  end

  def register(schema, parent)
    raise "Element has to be defined within a Schema tag" if schema.blank?
    if parent.blank?
      schema.add_element(self)
    else
      parent.add_element(self)
      @parent = parent
    end
  end

  def schema=(schema)
    @namespaces.each { |key, value| schema.add_xmlns(key, value) }
    super
  end

  def add_xmlns(prefix, uri)
    if @schema
      @schema.add_xmlns(prefix, uri) 
    else
      @namespaces[prefix] = uri
    end
  end

  def close_element
  end
end
