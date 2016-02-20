class StringRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    return h.capture { block.call(resource) } if block_given?
    options.reverse_merge!(class: nil)
    html_class = options.delete(:class)

    html_attributes = {
      class: html_class
    }

    value = value_for_attribute(attribute_name)
    value = value.to_s unless value.is_a?(String)

    helper.capture do
      h.content_tag(:div, html_attributes) { value }
    end
  end
end