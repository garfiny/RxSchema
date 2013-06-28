require 'spec_helper'

describe RxSchema::ElementStack do

  let(:stack) { RxSchema::ElementStack.new }
  let(:elem1) do 
    elem = Struct.new('Element', :name).new
    elem.name = "Customer"
    elem
  end
  let(:elem2) { elem = Struct.new('ComplexType').new }
  let(:element_tag_name) { 'element' }

  describe '#pop' do
    it 'pop up the last element from the stack' do
      stack.push elem1
      stack.push elem2
      stack.pop.should == elem2
    end
  end

  describe '#retro' do
    it 'returns an array which contains the first matching element and the following elements' do
      stack.push elem2
      stack.push elem1
      stack.push elem2
      stack.push elem1
      stack.push elem2
      stack.retro(element_tag_name).should == [elem1, elem2]
    end
  end

  describe '#push' do
    it 'push the element into the stack' do
      stack.push elem1
      stack.empty?.should be_false
      stack.pop.should == elem1
    end
  end

  describe '#empty?' do
    it 'returns true when stack is emtpy' do
      stack.push elem1
      stack.pop
      stack.empty?.should be_true
    end
    it 'returns false when stack is not empty' do
      stack.push elem1
      stack.empty?.should be_false
    end
  end
end
