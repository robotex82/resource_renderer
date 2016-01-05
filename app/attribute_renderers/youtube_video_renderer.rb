class YoutubeVideoRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(width: 640, height: 480, aspect_ratio: '16by9')
    aspect_ratio = options.delete(:aspect_ratio)
    # width = options.delete(:width)
    # height = options.delete(:height)

    iframe_attributes = {
      class: 'embed-responsive-item',
      # width: width,
      # height: height,
      src: "https://www.youtube.com/embed/#{model.identifier}",
      frameborder: '0'
    }

    h.content_tag(:div, class: "embed-responsive embed-responsive-#{aspect_ratio}") do
      h.content_tag(:iframe, nil, iframe_attributes)
    end
  end
end