class AwesomeNestedSetRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    options.reverse_merge!(scope: nil)

    scope = options.delete(:scope)

    # scope = "#{scope}_id".intern if scope.is_a?(Symbol) && scope.to_s !~ /_id$/

    data_attributes = {
      'awesome-nested-set-item':                true,
      'awesome-nested-set-item-uid':            model.to_param,
      'awesome-nested-set-item-on-drop-target': h.url_for([:reposition, model])
    }
    # data_attributes['awesome-nested-set-item-scope'] = "#{scope}-#{model.send(scope)}" if scope.present?
    data_attributes['awesome-nested-set-item-scope'] = scope.call(model) if scope.present?


    h.content_tag(:span, data: data_attributes, class: 'btn btn-xs btn-default awesome-nested-set-item') do
      h.tag(:span, class: 'glyphicon glyphicon-sort')
    end
  end
end