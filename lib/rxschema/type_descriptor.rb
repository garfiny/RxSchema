class RxSchema::TypeDescriptor

  TYPE_SOURCES = [SELF_DEFINED, XSD_TYPE]

  attr_accessor :name, :prefix

  def initialize(name, prefix)
    @name, @prefix = name, prefix
  end

end
