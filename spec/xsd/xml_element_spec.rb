require 'spec_helper'

describe RxSchema::XSD::XMLElement do

  let(:prefix) { 'pre' }
  let(:xmlns) { { xs: "xs_ns_uri", tns: "tns_ns_uri" }}
  let(:version) { RxSchema::XSD::Attribute.new('version', '1.1', nil) }
  let(:attribute_form_default) { RxSchema::XSD::Attribute.new('attributeFormDefault', 'qualified', nil) }
  let(:element_form_default) { RxSchema::XSD::Attribute.new('elementFormDefault', 'qualified', nil) }
  let(:target_namespace) { RxSchema::XSD::Attribute.new('targetNamespace', 'http://target_namespace_uri', nil) }
  let(:other_attributes) { [RxSchema::XSD::Attribute.new('customField', 'any value', 'any_prefix')] }
  let(:attrs) { [ attribute_form_default, element_form_default, target_namespace, version ] }

  class DummyElem < RxSchema::XSD::XMLElement
    attr_accessor :namespaces
    def initialize
      super
      @namespaces = {}
    end

    def self.new_dummy(prefix = nil, xmlns = {}, attrs = [])
      init_xml_element(prefix, xmlns, attrs)
    end

    def add_xmlns(prefix, uri)
      @namespaces[prefix] = uri
    end
  end

  describe '.init_xml_element' do
    subject { DummyElem.new_dummy(prefix, xmlns, attrs + other_attributes) }
    its(:prefix) { should == prefix; }
    its(:namespaces) { should == xmlns }
    its(:attribute_form_default) { should == 'qualified' }
    its(:element_form_default) { should == 'qualified' }
    its(:version) { should == '1.1' }
    its(:custom_field) { should == 'any value' }
    its(:attributes) { should == attrs + other_attributes }
  end

  describe '#add_attribute' do
  end

  describe 'status' do
  end
end
