class TextResourceRenderer < ResourceRenderer::ResourceRenderer::Base
  def render(&block)
    helper.content_tag(:pre) do
      block_given? ? block.call(self) : resource.inspect
    end
  end
end