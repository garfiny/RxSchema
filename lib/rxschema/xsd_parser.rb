require 'nokogiri'

class RxSchema::XSDParser

  def self.parse(event_handler: RxSchema::SAXEventHandler.new(self.new), file: nil)
    if file
      parser = Nokogiri::XML::SAX::Parser.new(event_handler)
      parser.parse(file)
    end
  end

  attr_reader :schemas

  def initialize
    @schemas = []
  end

  def start_parsing
  end

  def end_parsing
    binding.pry
  end

  def add_xml_element(xml_element)
    if schema?(xml_element)
      self.add_schema(xml_element) 
    else
      self.add_element(xml_element)
    end
  end

  def add_schema(schema)
    @schemas << schema
  end

  def current_schema
    @schemas.last if @schemas.last.open?
  end

  def add_element(element)
    element.register(current_schema, current_open_element)
  end

  def close_element(qname)
    current_open_element.close! if current_open_element && current_open_element.qname == qname
  end

  def current_element
    current_schema.try(:last_element)
  end
  private

  def last_element_of_schema(schema)
    schema.last_element
  end

  def current_open_element
    if !last_element_of_schema(current_schema).blank? && last_element_of_schema(current_schema).open?
      last_element_of_schema(current_schema) 
    end
  end

  def schema?(xml_element)
    xml_element.class.name.demodulize.downcase == 'schema' && 
      xml_element.uri == RxSchema::NS_SCHEMA
  end
end
