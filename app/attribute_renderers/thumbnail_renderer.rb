class ThumbnailRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(style: :thumb, image_tag_options: { class: 'thumbnail' })
    style = options.delete(:style)
    image_tag_options = options.delete(:image_tag_options)

    attachment = value_for_attribute(attribute_name)
    return unless attachment.respond_to?(:url)
    source = attachment.url(style)
    
    helper.link_to(attachment.url, { data: { gallery: 'gallery' } }) do
      helper.image_tag(source, image_tag_options)
    end
  end
end