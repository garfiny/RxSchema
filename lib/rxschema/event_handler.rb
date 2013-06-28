require 'nokogiri'

class RxSchema::EventHandler < Nokogiri::XML::SAX::Document

  def initialize
    @stack = RxSchema::ElementStack.new
    @builder = RxSchema::ElementStructBuilder.new
  end

  def start_document
    p "========= start document"
  end

  def end_document
    p "================== end_document"
  end

  def start_element_namespace(name, attrs = [], prefix = nil, uri = nil, ns = [])
    attributes = ns.map { |ns_prefix,ns_uri|
      [['xmlns', ns_prefix].compact.join(':'), ns_uri]
    } + attrs.map { |attr|
      [[attr.prefix, attr.localname].compact.join(':'), attr.value]
    }
    # p "================== start_element_namespace #{prefix}:#{name} === #{attributes}"
    attrs = if attributes.empty?
              {}
            else
              attributes.map { |value| 
                Hash[*value] 
              }.reduce(:merge).with_indifferent_access.symbolize_keys
            end
    schema_element?(name, attrs, prefix, uri, ns)
    if element_tag_name == 'element'
      @stack.push(@builder.build(element_tag_name: name, tag_prefix: prefix, **attrs))
    end
  end

  def schema_element?(name, attrs = [], prefix = nil, uri = nil, ns = [])
    if name == 'schema' && uri == RxSchema::NS_SCHEMA
      # @schema = RxSchema::XSD::Schema.new
      # @schema.parse_attributes(attrs)
      # @schema.parse_namespaces(ns)
      p name
      p "===prefix: #{prefix}"
      p "===attrs: #{attrs}"
      p "===ns: #{ns}"
      p "===uri: #{uri}"
    end
  end

  def end_element_namespace(name, prefix = nil, uri = nil)
    # p "================== end_element_namespace: #{name}"
    start = @stack.retro(name)
    RxSchema::TypeBuilder.build(start, nil)
  end

  def cdata_block(str)
    # p "================== cdata_block: #{str}"
  end

  def characters(chars)
    # p "================== characters: #{chars}"
  end

  def comment(comment)
    # p "================== comment: #{comment}"
  end

  def warning(warning_str)
    # p "================== warning: #{warning_str}"
  end

  def error(error_str)
    # p "================== error: #{error_str}"
  end

  def xmldecl(version, encoding, standalone)
    # p "================== xmldecl"
    # p version, encoding, standalone
  end
end
