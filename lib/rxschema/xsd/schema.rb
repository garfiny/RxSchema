class RxSchema::XSD::Schema < RxSchema::XSD::XMLElement

  attr_accessor :namespaces

  def initialize
    @namespaces = {}.with_indifferent_access
    super
  end

  def add_xmlns(prefix, uri)
    @namespaces[prefix] = uri unless @namespaces.has_key?(prefix)
  end

  def namespaces
    @namespaces
  end

  def get_uri_by_prefix(prefix)
    @namespaces[prefix]
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
