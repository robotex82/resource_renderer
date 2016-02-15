class ArrayRenderer < ResourceRenderer::AttributeRenderer::Base
  private

  def value_for_attribute(attribute_name)
    model.send(attribute_name).to_sentence
  end
end