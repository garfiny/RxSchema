require 'spec_helper'

describe RxSchema::XSD::Schema do

  let(:prefix) { nil }
  let(:xmlns) { { xs: "xs_ns_uri", tns: "tns_ns_uri" }}
  let(:version) { RxSchema::XSD::Attribute.new('version', '1.1', nil) }
  let(:attribute_form_default) { RxSchema::XSD::Attribute.new('attributeFormDefault', 'qualified', nil) }
  let(:element_form_default) { RxSchema::XSD::Attribute.new('elementFormDefault', 'qualified', nil) }
  let(:target_namespace) { RxSchema::XSD::Attribute.new('targetNamespace', 'http://target_namespace_uri', nil) }
  let(:other_attributes) { [RxSchema::XSD::Attribute.new('customField', 'any value', 'any_prefix')] }
  let(:attributes) { [ attribute_form_default, element_form_default, target_namespace, version ] }

  describe 'build new schema' do
    subject { RxSchema::XSD::Schema.new_schema(prefix, xmlns, attributes + other_attributes) }
    its(:prefix) { should == prefix }
    its(:attribute_form_default) { should == 'qualified' }
    its(:element_form_default) { should == 'qualified' }
    its(:version) { should == '1.1' }
    its(:namespaces) { should == xmlns }
    its(:custom_field) { should == 'any value' }
  end
end
