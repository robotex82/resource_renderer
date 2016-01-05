class TextRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    editor_syntax = options.delete(:editor_syntax)

    html_attributes = {
      id: "#{model.class.name.parameterize}-#{model.to_param}",
      'data-add-editor': true
    }
    html_attributes[:'data-editor-syntax'] = editor_syntax if editor_syntax.present?

    h.content_tag(:pre, html_attributes) { value_for_attribute(attribute_name) }
  end
end