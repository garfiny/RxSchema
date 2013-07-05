require 'erb'

class RxSchema::Generator

  def initialize(type_templates)
    @type_templates = type_templates
  end

  def generate
    @type_templates.each do |template|
    end
  end

  def generate_from_template(template)
    template.type_descriptor.name
    erb = ERB.new(RxSchema::RubyClassTemplate::TEMPLATE)
    erb.result(binding)
  end

end

class RxSchema::RubyClassTemplate

  TEMPLATE = <<-EOF
  class <%=template.class_name%>
    <%- template.attributes.each do |attr| %>
      attribute :<%=attr.name%>, <%=attr.type_name%>
    <% end %>
  end
  EOF
end
