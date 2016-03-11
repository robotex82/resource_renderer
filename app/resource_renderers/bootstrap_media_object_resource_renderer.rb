class BootstrapMediaObjectResourceRenderer < ResourceRenderer::ResourceRenderer::Base
  def media_object(options = {})
    options.reverse_merge!(
      title_method: :title,
      body_method: :body,
      image_method: :image, 
      image_url_method: :url,
      body: nil,
      title: nil,
      media_body_content_html_options: { class: 'media-body-content.bottom-margin-1' },
      link_url: nil
    )
    title            = options.delete(:title)
    title_method     = options.delete(:title_method)
    body_method      = options.delete(:body_method)
    body             = options.delete(:body)
    image_method     = options.delete(:image_method)
    image_url_method = options.delete(:image_url_method)
    image_url        = options.delete(:image_url)
    link_to_more_url = options.delete(:link_to_more_url)
    link_url         = options.delete(:link_url)
    media_body_content_html_options = options.delete(:media_body_content_html_options)

    locals = {
      title:            title     || @resource.send(title_method),
      body:             body      || @resource.send(body_method),
      image_src:        image_url || @resource.send(image_method).send(:try, image_url_method),
      link_url:         link_url  || helper.url_for(@resource),
      link_to_more_url: link_to_more_url,
      media_body_content_html_options: media_body_content_html_options
    }

    helper.render partial: 'resource_renderers/bootstrap_media_object_resource_renderer', locals: locals
  end
end
