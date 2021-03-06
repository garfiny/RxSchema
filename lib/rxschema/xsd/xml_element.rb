class RxSchema::XSD::XMLElement

  attr_accessor :prefix, :attributes, :status, :elements, :schema, :uri

  def initialize
    @attributes = []
    @elements   = []
    @status     = :open
    @schema     = nil
    @uri        = nil
  end

  def self.new_instance(prefix = nil, uri = nil, xmlns = {}, attrs = [])
    instance = self.new
    instance.prefix = prefix
    instance.uri = uri
    if instance.respond_to?(:add_xmlns)
      xmlns.each { |key, value| instance.add_xmlns(key, value) }
    end
    attrs.each { |attr| instance.add_attribute(attr) }
    instance
  end

  def register(schema, parent)
  end

  def qname
    (self.prefix.blank? ? "" : self.prefix) + self.name
  end

  def add_attribute(attribute)
    define_instance_variable_if_not_defined(attribute.name, attribute.value) 
    define_prefix_method_if_not_defined(attribute.name, attribute.prefix)
    @attributes.push attribute
  end

  def define_instance_variable_if_not_defined(attr_name, value)
    unless self.instance_variable_defined?("@#{attr_name}")
      self.instance_variable_set("@#{attr_name}", value)
      self.instance_eval "def #{attr_name}; @#{attr_name}; end"
    end
  end

  def define_prefix_method_if_not_defined(attr_name, prefix)
    unless self.respond_to?("#{attr_name}_prefix")
      self.instance_eval "def #{attr_name}_prefix; #{prefix}; end"
    end
  end

  def close!
    self.status = :closed
  end

  def closed?
    !self.open?
  end

  def open?
    self.status.to_s.inquiry.open?
  end

  def add_element(element)
    @elements << element
  end

  def last_element
    @elements.last
  end

  def in_same_namespace(element)
    self.target_namespace_uri == element.target_namespace_uri
  end

  def target_namespace_uri
    return self.target_namespace if self.respond_to?(:target_namespace)
    return nil if self.prefix.blank?
    schema.get_uri_by_prefix(self.prefix) if schema
  end
end
