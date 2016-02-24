class MoneyRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(format: :long)
    format = options.delete(:format)

    money = value_for_attribute(attribute_name)
    
    "#{h.humanized_money(money)} #{money.currency}".html_safe
  end
end