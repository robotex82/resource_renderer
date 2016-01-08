class AssociationRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(label_method: :to_s)
    label_method = options.delete(:label_method)

    associated = value_for_attribute(attribute_name)

    return if associated.nil?

    url = options.delete(:url)
    label = associated.send(label_method)

    return label if url === false

    target = url.present? ? url.call(model) : associated

    return if target.nil?
    h.link_to(label, target)
  end
end