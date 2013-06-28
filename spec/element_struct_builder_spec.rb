require 'spec_helper'

describe RxSchema::ElementStructBuilder do

  describe '.build' do

    let(:struct_builder) { RxSchema::ElementStructBuilder.new }
    let(:element_tag_name) { 'element' }
    let(:tag_prefix) { 'xs' }
    let(:attributes) { { name: 'Timestamp', type: 'xs:dateTime', ns: ["ns1", "ns2"] } }

    before do
      @struct = struct_builder.build(
        element_tag_name: element_tag_name,
        tag_prefix: tag_prefix, **attributes
      )
    end

    it 'creates a new struct subtype and subtype name equals to element tag name' do
      @struct.class.name.demodulize.downcase.should == element_tag_name
    end
    
    it 'builds a Struct object' do
      @struct.should be_kind_of Struct
    end

    it "has memeber: 'prefix'" do
      @struct.members.should be_include :prefix
    end

    it 'sets the value of prefix' do
      @struct.prefix.should == tag_prefix
    end

    it 'contains other extra attributes' do
      attributes.each_key do |key|
        @struct.members.should be_include key
      end
    end

    it 'set the value of extra attributes' do
      attributes.each do |key, value|
        @struct.send(key).should == value
      end
    end
  end
end
