class RxSchema::TypeBuilder

  def self.build(elem_structs, schema)
    elem_structs.each do |struct|
      case struct.class.name.demodulize.underscore
      when 'attribute'
        RxSchema::AttributeTypeBuilder.new.build_type(struct)
      when 'sequence'
      when 'complex_type'
      when 'element'
      end
    end
  end
end

class RxSchema::ElementTypeBuilder < RxSchema::TypeBuilder

  def build_type(meta_obj)
  end
end

class RxSchema::AttributeTypeBuilder < RxSchema::TypeBuilder

  def build_type(meta_obj)
    @meta = meta_obj
    p "=====#{@meta}"
    name = meta_obj.name
    type = meta_obj.type
    ["attribute :#{name.underscore} #{type}", define_validation(name)]
  end

  def define_validation(name)
    "validates :#{name.underscore}, presence: true"
  end

  def define_class
  end

  def define_attributes
  end
end
