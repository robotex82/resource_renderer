class AssociationRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(label_method: :to_s)
    label_method = options.delete(:label_method)

    associated = value_for_attribute(attribute_name)

    return if associated.nil?

    url = options.delete(:url)
    label = associated.send(label_method)

    target = url.call(model) if url.is_a?(Proc)
    target = url if url.is_a?(String)
    target = associated if url.is_a?(TrueClass)

    if target.nil?
      label
    else
      h.link_to(label, target)
    end
  end
end