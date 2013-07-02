require 'nokogiri'

class RxSchema::SAXEventHandler < Nokogiri::XML::SAX::Document

  def initialize(parser)
    @parser = parser
  end

  def start_document
    @parser.start_parsing
  end

  def end_document
    @parser.end_parsing
  end

  def start_element_namespace(name, attrs = [], prefix = nil, uri = nil, ns = [])
    attributes = convert_attributes(attrs)
    namespace_hash = ns_to_hash(ns)
    if schema?(name, uri)
      @parser.add_schema(RxSchema::XSD::Schema.new_schema(prefix, namespace_hash, attributes))
    elsif element?(name)
      @parser.add_element(RxSchema::XSD::Element.new_element(@parser.current_schema, prefix, namespace_hash, attributes))
    end
  end

  def convert_attributes(attrs)
    attrs.map { |attr| RxSchema::XSD::Attribute.new(attr.localname, attr.value, attr.prefix) }
  end

  def ns_to_hash(ns)
    Hash[*ns.flatten]
  end

  def schema?(name, uri = nil)
    name.downcase == 'schema' && uri == RxSchema::NS_SCHEMA
  end

  def element?(name)
    name.downcase == 'element'
  end

  def end_element_namespace(name, prefix = nil, uri = nil)
    @parser.close_element((prefix.blank? ? "" : prefix) + name)
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
