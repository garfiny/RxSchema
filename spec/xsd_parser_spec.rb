require 'spec_helper'

describe RxSchema::XSDParser do

  let(:parser) { RxSchema::XSDParser.new }

  describe '#parse' do
    it 'parses xsd file' do
    end
  end

  describe '#add_xml_element' do
    let(:schema) do
      schema = RxSchema::XSD::Schema.new
      schema.uri = RxSchema::NS_SCHEMA
      schema
    end
    let(:element) { elemenet = RxSchema::XSD::Element.new }
    
    context 'when passed xml element is a schema' do
      it 'addx xml element into schema' do
        parser.should_receive(:add_schema).with(schema)
        parser.add_xml_element(schema)
      end
    end
    context 'when passed xml element is not a schema' do
      it 'adds xml element into elements' do
        parser.should_receive(:add_element).with(element)
        parser.add_xml_element(element)
      end
    end
  end

  describe '#add_schema' do
    let(:schema) { mock('schema') }
    it 'adds schema' do
      -> { parser.add_schema(schema) }.should change(parser.schemas, :length).to(1)
    end
  end

  describe '#current_schema' do
    let(:schema1) { mock('schema1') }
    let(:schema2) { mock('schema2', open?: true) }
    let(:schema3) { mock('schema2', open?: false) }
    it 'returns the last added schema' do
      parser.add_schema(schema1)
      parser.add_schema(schema2)
      parser.current_schema.should == schema2
    end
    it 'returns nil if the last added schema is closed' do
      parser.add_schema(schema1)
      parser.add_schema(schema2)
      parser.add_schema(schema3)
      parser.current_schema.should be_nil
    end
  end

  describe '#add_element' do
    let(:element) { elemenet = RxSchema::XSD::Element.new }
    before do
      parser.add_schema(mock('schema', open?: true, last_element: mock('element', open?: true)))
    end

    it 'registers itself' do
      element.should_receive(:register)
      parser.add_element(element)
    end
  end
end
