require 'spec_helper'

describe RxSchema::XSD::Schema do

  let(:prefix) { nil }
  let(:xmlns) { { xs: "xs_ns_uri", tns: "tns_ns_uri" }}
  let(:attributes) { [RxSchema::XSD::Attribute.new('customField', 'any value', 'any_prefix')] }

  describe 'build new schema' do
    it "uses RxSchema::XSD::XMLElement init_xml_element" do
      RxSchema::XSD::XMLElement.should_receive(:init_xml_element)
      RxSchema::XSD::Schema.new_schema(prefix, xmlns, attributes) 
    end
  end
end
