require 'spec_helper'

describe RxSchema::XSD::ComplexType do

  let(:complex_type) { RxSchema::XSD::ComplexType.new_instance(nil, nil, nil, nil) }

  describe '#register' do
    it 'triggers a type definition'
    context 'when complex type has name attribute' do
      it 'marks itself as a type_class'
    end
    context 'when complex type has no name attribute' do
    end
  end
end
