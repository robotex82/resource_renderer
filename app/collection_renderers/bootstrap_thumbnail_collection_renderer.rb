class BootstrapThumbnailCollectionRenderer < ResourceRenderer::CollectionRenderer::Base
  def render(&block)
    helper.capture do
      helper.content_tag(:div, class: 'row') do
        render_collection(&block)
      end
    end
  end
end
