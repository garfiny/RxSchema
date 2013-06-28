class RxSchema::XSDDomReader
  
  def load_dom(file)
    doc = Nokogiri::XML(File.open(file)) do |config|
      # config.options = Nokogiri::XML::ParseOptions.STRICT | Nokogiri::XML::ParseOptions.NONET
    end
  end
end
