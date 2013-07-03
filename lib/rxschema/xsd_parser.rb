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

  def add_schema(schema)
    @schemas << schema
  end

  def current_schema
    @schemas.last if @schemas.last.open?
  end

  def current_element
    current_schema.try(:last_element)
  end

  def last_element_of_schema(schema)
    schema.last_element
  end

  def has_parent_element?
    !last_element_of_schema(current_schema).blank? &&
      last_element_of_schema(current_schema).open?
  end
  private :has_parent_element?

  def add_element(element)
    if has_parent_element?
      last_element_of_schema(current_schema).add_element(element)
    else
      current_schema.add_element(element)
    end
  end

  def close_element(qname)
    current_element.try(:close!) if current_element.qname == qname
  end
end
