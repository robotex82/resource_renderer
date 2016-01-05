class EmailRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    return h.capture { block.call(resource) } if block_given?
    options.reverse_merge!(class: 'email')
    html_class = options.delete(:class)

    html_attributes = {
      class: html_class
    }

    helper.capture do
      h.content_tag(:div, html_attributes) { h.mail_to value_for_attribute(attribute_name) }
    end
  end
end