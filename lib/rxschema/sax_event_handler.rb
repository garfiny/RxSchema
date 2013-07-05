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
    return unless element_class_defined?(name)
    @parser.add_xml_element(create_xml_element(name, attrs, prefix, uri, ns))
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

  private

  def element_class_defined?(element_name)
    RxSchema::XSD.const_defined? element_name.camelize.to_sym
  end

  def create_xml_element(element_name, attrs = [], prefix = nil, uri = nil, ns = [])
    element_class(element_name).new_instance(prefix, uri, ns_to_hash(ns), xml_attributes(attrs))
  end

  def element_class(element_name)
    "RxSchema::XSD::#{element_name.camelize}".constantize
  end

  def xml_attributes(attrs)
    attrs.map { |attr| RxSchema::XSD::XMLAttribute.new(attr.localname, attr.value, attr.prefix) }
  end

  def ns_to_hash(ns)
    Hash[*ns.flatten]
  end
end
