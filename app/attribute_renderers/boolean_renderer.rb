class BooleanRenderer < ResourceRenderer::AttributeRenderer::Base
  private

  def value_for_attribute(attribute_name)
    I18n.t("booleans.#{model.send(attribute_name).to_s}")
  end
end