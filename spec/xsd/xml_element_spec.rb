require 'spec_helper'

describe RxSchema::XSD::XMLElement do

  let(:prefix) { 'pre' }
  let(:prefix_uri) { 'pre_ns_uri' }
  let(:uri) { 'http://uri' }
  let(:xmlns) { { xs: "xs_ns_uri", tns: "tns_ns_uri", pre: prefix_uri }}
  let(:version) { RxSchema::XSD::XMLAttribute.new('version', '1.1', nil) }
  let(:attribute_form_default) { RxSchema::XSD::XMLAttribute.new('attributeFormDefault', 'qualified', nil) }
  let(:element_form_default) { RxSchema::XSD::XMLAttribute.new('elementFormDefault', 'qualified', nil) }
  let(:target_namespace) { RxSchema::XSD::XMLAttribute.new('targetNamespace', 'http://target_namespace_uri', nil) }
  let(:other_attributes) { [RxSchema::XSD::XMLAttribute.new('customField', 'any value', 'any_prefix')] }
  let(:attrs) { [ attribute_form_default, element_form_default, target_namespace, version ] }

  class DummyElem < RxSchema::XSD::XMLElement
    attr_accessor :namespaces, :schema
    def initialize
      super
      @namespaces = {}
      @schema = nil
    end

    def schema=(schema)
      @namespaces.each { |key, value| schema.add_xmlns(key, value) }
      super
    end

    def add_xmlns(prefix, uri)
      if @schema
        @schema.add_xmlns(prefix, uri) 
      else
        @namespaces[prefix] = uri
      end
    end
  end

  describe '.new_instance' do
    subject { DummyElem.new_instance(prefix, uri, xmlns, attrs + other_attributes) }
    its(:prefix) { should == prefix; }
    its(:namespaces) { should == xmlns }
    its(:attribute_form_default) { should == 'qualified' }
    its(:element_form_default) { should == 'qualified' }
    its(:version) { should == '1.1' }
    its(:custom_field) { should == 'any value' }
    its(:attributes) { should == attrs + other_attributes }
  end

  describe '#add_element' do
    let(:elem1) { DummyElem.new_instance(prefix, uri, xmlns, attrs + other_attributes) }
    let(:elem2) { DummyElem.new_instance(prefix, uri, xmlns, attrs + other_attributes) }
    it 'adds element' do
      ->{ elem1.add_element(elem2) }.should change(elem1.elements, :length).by(1)
    end
  end

  describe '#add_attribute' do
  end

  describe 'status' do
  end

  describe '#in_same_namespace' do
    let(:ns1) { RxSchema::XSD::XMLAttribute.new('targetNamespace', 'uri1', nil) }
    let(:ns2) { RxSchema::XSD::XMLAttribute.new('targetNamespace', 'uri2', nil) }
    let(:element) { DummyElem.new_instance(prefix, uri, xmlns, [ns1]) }
    it 'returns true if target element target_namespace is same' do
      target_element = DummyElem.new_instance(prefix, uri, xmlns, [ns1]) 
      element.in_same_namespace(target_element).should be_true
    end
    it 'returns false if target element target_namespace is not same' do
      target_element = DummyElem.new_instance(prefix, uri, xmlns, [ns2]) 
      element.in_same_namespace(target_element).should be_false
    end
  end

  describe '#target_namespace' do
    context 'when self has target_namespace defined' do
      let(:element) { DummyElem.new_instance(prefix, uri, xmlns, [target_namespace]) }
      it 'returns target_namespace value' do
        element.target_namespace_uri.should == target_namespace.value
      end
    end
    context 'when self does not have target_namespace defined' do
      context 'when prefix is nil' do
        it 'returns nil' do
          DummyElem.new_instance(nil, nil, xmlns, []).target_namespace_uri.should be_nil
        end
      end
      context 'when prefix is not nil' do
        let(:schema) { RxSchema::XSD::Schema.new_instance(prefix, uri, xmlns, []) }
        it 'returns prefix related namespace uri through from schema' do
          elem = DummyElem.new_instance(prefix, nil, xmlns, [])
          elem.schema = schema
          elem.target_namespace_uri.should == prefix_uri
        end
      end
    end
  end
end
