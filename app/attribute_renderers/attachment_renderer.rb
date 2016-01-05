class AttachmentRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(format: :long)
    format = options.delete(:format)
    
    h.link_to(value_for_attribute(attribute_name).url) do
      h.tag(:span, class: 'btn btn-xs btn-primary btn-responsive') +
      h.content_tag(:span, h.t(".download"), class: 'btn-text')
    end
  end
end