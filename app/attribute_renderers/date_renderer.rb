class DateRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(format: :long)
    format = options.delete(:format)
    
    I18n.l(value_for_attribute(attribute_name), format: format)
  end
end