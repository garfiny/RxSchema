require 'spec_helper'

describe RxSchema::XSD::Element do
  
  let(:prefix) { nil }
  let(:xmlns) { { xs: "xs_ns_uri", tns: "tns_ns_uri" }}
  let(:attributes) { [RxSchema::XSD::Attribute.new('customField', 'any value', 'any_prefix')] }
  let(:schema) { mock('schema') }

  describe 'build new schema' do
    before do
      RxSchema::XSD::XMLElement.stub(:init_xml_element).and_return(mock('element').as_null_object)
    end
    it "uses RxSchema::XSD::XMLElement init_xml_element" do
      RxSchema::XSD::XMLElement.should_receive(:init_xml_element)
      RxSchema::XSD::Element.new_element(schema, prefix, xmlns, attributes) 
    end
  end
end
