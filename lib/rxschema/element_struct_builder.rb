class RxSchema::ElementStructBuilder

  def build(element_tag_name: '', tag_prefix: nil, **attributes)
    struct_class = create_element_struct_class(element_tag_name, attributes)
    instantiate_struct_class(struct_class, tag_prefix, attributes)
  end

  private

  def instantiate_struct_class(struct_class, tag_prefix, **attributes)
    attrs = attributes || Hash.new
    attrs[:prefix] = tag_prefix
    struct_class.new(*attrs.values)
  end

  def create_element_struct_class(element_tag_name, attributes)
    class_name = constantize_tag_name(element_tag_name.to_s)
    members = attributes.keys + [:prefix]
    Struct.new(class_name, *members)
  end

  def constantize_tag_name(tag_name)
    tag_name.camelize
  end

  def members_of_element(attributes)
    attributes.keys
  end

end
