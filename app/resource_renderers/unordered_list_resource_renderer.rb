class UnorderedListResourceRenderer < ResourceRenderer::ResourceRenderer::Base
  def display(attribute_name, options = {})
    options.reverse_merge!(html_options: default_html_options_for(attribute_name))

    html_options = options.delete(:html_options)
    helper.content_tag(:li, html_options) do
      helper.content_tag(:span, translated_attribute_name(attribute_name), class: 'key') + 
      helper.content_tag(:span, attribute_value(attribute_name), class: 'value')
    end
  end

  def render(&block)
    helper.content_tag(:ul) do
      block.call(self)
    end
  end

  private 

  def default_html_options_for(attribute_name)
    { role: attribute_name.to_s.dasherize }
  end
end