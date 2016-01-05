class TextResourceRenderer < ResourceRenderer::ResourceRenderer::Base
  def render(&block)
    helper.content_tag(:pre) do
      block.call(self)
    end
  end
end