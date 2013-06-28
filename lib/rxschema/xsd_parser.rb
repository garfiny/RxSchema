require 'nokogiri'

class RxSchema::XSDParser

  def self.parse(event_handler: RxSchema::EventHandler.new(self.new), file: nil)
    if file
      parser = Nokogiri::XML::SAX::Parser.new(event_handler)
      parser.parse(file)
    end
  end

  def initialize
    @stack = RxSchema::ElementStack.new
    @builder = RxSchema::ElementStructBuilder.new
    @current_schema = nil
    @schemas = []
  end

  def start_parsing
  end

  def end_parsing
  end

  def add_schema(prefix, nampespaces, attributes)
    Struct.new("Schema")
  end

  def add_element
  end
end
