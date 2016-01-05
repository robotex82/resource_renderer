class ImageRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(format: :long)
    format = options.delete(:format)
    
    h.image_tag(value_for_attribute(attribute_name).url, class: 'img-responsive')
  end
end