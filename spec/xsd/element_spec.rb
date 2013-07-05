require 'spec_helper'

describe RxSchema::XSD::Element do
  
  let(:prefix) { nil }
  let(:uri) { 'http://uri' }
  let(:xmlns) { { xs: "xs_ns_uri", tns: "tns_ns_uri" }}
  let(:attributes) { [RxSchema::XSD::XMLAttribute.new('customField', 'any value', 'any_prefix')] }
  let(:schema) { mock('schema', add_element: nil) }
  let(:parent_element) { mock('element', add_element: nil) }
  let(:element) { RxSchema::XSD::Element.new_instance(prefix, uri, xmlns, attributes) }

  describe '#register' do
    context 'when schema is blank' do
      it 'raise an error' do
        -> { element.register(nil, nil) }.should raise_error
      end
    end
    context 'when schema is not blank' do
      context 'when there is no parent element' do
        it 'register itself into schema' do
          schema.should_receive(:add_element).with(element)
          element.register(schema, nil)
        end
      end
      context 'when there is parent element' do
        it 'register itself into parent element' do
          parent_element.should_receive(:add_element).with(element)
          element.register(schema, parent_element)
        end

        it 'sets parent element to be passed in element' do
          element.register(schema, parent_element)
          element.instance_variable_get("@parent").should == parent_element
        end
      end
    end
  end
end
