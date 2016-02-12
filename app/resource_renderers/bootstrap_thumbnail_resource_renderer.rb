class BootstrapThumbnailResourceRenderer < ResourceRenderer::ResourceRenderer::Base
    def render(&block)
    helper.content_tag(:div, { :'data-target' => '#modal-gallery', :'data-toggle' => 'modal-gallery'}) do
      block.call(self)
    end
  end

  def thumbnail(attribute_name, options = {}, &block)
    options.reverse_merge!(as: :thumbnail, image_tag_options: { class: 'thumbnail img-responsive' })

    helper.content_tag(:div, class: 'col-xs-12 col-sm-6 col-md-4 col-lg-2') do
      display(attribute_name, options, &block)
    end
  end
end
