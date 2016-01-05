class ActsAsListRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(scope: nil)

    scope = options.delete(:scope)

    scope = "#{scope}_id".intern if scope.is_a?(Symbol) && scope.to_s !~ /_id$/

    data_attributes = {
      'acts-as-list-item': true,
      'acts-as-list-item-uid': model.to_param,
      'acts-as-list-item-on-drop-target': h.url_for([:reposition, model])
    }
    data_attributes['acts-as-list-item-scope'] = "#{scope}-#{model.send(scope)}" if scope.present?


    h.content_tag(:span, data: data_attributes, class: 'btn btn-xs btn-default acts-as-list-item') do
      h.tag(:span, class: 'glyphicon glyphicon-sort')
    end
  end
end