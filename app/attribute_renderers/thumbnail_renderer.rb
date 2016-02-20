class ThumbnailRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(style: :thumb, image_tag_options: { class: 'thumbnail' })
    style = options.delete(:style)
    link_to_url_proc = options.delete(:link_to_url) # .try(:call, resource)
    link_to_url = helper.instance_exec(model, &link_to_url_proc) if link_to_url_proc.respond_to?(:call)
    image_tag_options = options.delete(:image_tag_options)

    attachment = value_for_attribute(attribute_name)
    return unless attachment.respond_to?(:url)
    source = attachment.url(style)
    link_to_target = link_to_url || attachment.url
    
    helper.link_to(link_to_target, { data: { gallery: 'gallery' } }) do
      helper.image_tag(source, image_tag_options)
    end
  end
end