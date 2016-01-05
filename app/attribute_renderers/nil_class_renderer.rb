class NilClassRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(field, label, options = {}, &block)
    ''
  end
end