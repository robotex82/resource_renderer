class BootstrapMediaObjectResourceRenderer < ResourceRenderer::ResourceRenderer::Base
  def media_object(options = {})
    options.reverse_merge!(title_method: :title, body_method: :body, image_method: :image, image_url_method: :url, body: nil)
    title_method     = options.delete(:title_method)
    body_method      = options.delete(:body_method)
    body             = options.delete(:body)
    image_method     = options.delete(:image_method)
    image_url_method = options.delete(:image_url_method)
    image_url        = options.delete(:image_url)

    locals = {
      title: @resource.send(title_method),
      body:  body || @resource.send(body_method),
      image_src: image_url || @resource.send(image_method).send(image_url_method),
      link_href: helper.url_for(@resource)
    }

    helper.render partial: 'resource_renderers/bootstrap_media_object_resource_renderer', locals: locals
  end
end
