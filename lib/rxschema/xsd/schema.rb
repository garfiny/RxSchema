class RxSchema::XSD::Schema
  include RxSchema::XSD::XMLElement

  attr_accessor :prefix

  def initialize
    @namespaces ||= {}
    @attributes ||= []
  end

  def self.new_schema(prefix = nil, xmlns = {}, attrs = [])
    schema = self.new
    schema.prefix = prefix
    xmlns.each { |key, value| schema.add_xmlns(key, value) }
    attrs.each { |attr| schema.add_attribute(attr) }
    schema
  end

  def add_xmlns(prefix, uri)
    @namespaces[prefix] = uri
  end

  def namespaces
    @namespaces
  end

  class ::XSDSpecification
    # attr_accessor :id #optional
    # attr_accessor :attribute_form_default #optional ( qualified|unqualified )
    # attr_accessor :element_form_default #optional ( qualified|unqualified )
    # attr_accessor :block_default #optional (#all|list of (extension|restriction|substitution))
    # attr_accessor :final_default #optional (#all|list of (extension|restriction|list|union))
    # attr_accessor :target_namespace #optional only URI
    # attr_accessor :version #optional
  end
end
