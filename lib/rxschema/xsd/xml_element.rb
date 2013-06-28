module RxSchema::XSD
  module XMLElement

    def add_attribute(attribute)
      define_instance_variable_if_not_defined(attribute.name, attribute.value) 
      define_prefix_method_if_not_defined(attribute.name, attribute.prefix)
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
  end
end
