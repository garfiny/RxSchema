require 'spec_helper'

describe RxSchema::XSD::Schema do

  let(:prefix1) { 'p1' }
  let(:prefix2) { 'p2' }
  let(:uri) { 'http://uri' }
  let(:xmlns) { { xs: "xs_ns_uri", tns: "tns_ns_uri" }}
  let(:attributes) { [RxSchema::XSD::XMLAttribute.new('customField', 'any value', 'any_prefix')] }
  let(:schema) { RxSchema::XSD::Schema.new_instance(prefix1, uri, xmlns, attributes) }

  describe '#add_xmlns' do
    before { schema.add_xmlns(prefix1, uri) }
    
    context 'when there is duplicate prefix' do
      it 'does not add duplicate xml namespace' do
        -> { 
          schema.add_xmlns(prefix1, uri) 
        }.should_not change(schema.namespaces, :length).by(1)
      end
    end

    context 'when there is no duplicate prefix' do
      it 'adds xml namespace' do
        -> { 
          schema.add_xmlns(prefix2, uri) 
        }.should change(schema.namespaces, :length).by(1)
      end
    end
  end

  def add_xmlns(prefix, uri)
    @namespaces[prefix] = uri unless @namespaces.has_key?(prefix)
  end
end
