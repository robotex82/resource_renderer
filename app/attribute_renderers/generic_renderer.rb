class GenericRenderer < ResourceRenderer::AttributeRenderer::Base
  private

  def value_for_attribute(attribute_name)
    model.send(attribute_name).inspect
  end
end