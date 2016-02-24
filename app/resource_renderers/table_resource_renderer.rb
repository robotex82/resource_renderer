class TableResourceRenderer < ResourceRenderer::ResourceRenderer::Base
  def column(attribute_name, options = {}, &block)
    build_table_data(attribute_name, options, &block)
  end

    def columns(*args)
      _ = args.extract_options!
      columns = *args || resource_class.attribute_names
      columns.collect do |name|
        column name
      end.join.html_safe
    end

  def render(&block)
    helper.content_tag(:tr) do
      block.call(self)
    end
  end

  def timestamps
    column(:created_at) +
    column(:updated_at)
  end


  def userstamps
    column(:creator) +
    column(:updater)
  end

  def acts_as_published_actions
    link_path = helper.controller.url_for(action: :toggle_published, id: resource.to_param)
    column(:published_actions) do |resource| 
      if resource.published?
        helper.link_to(link_path, class: 'btn btn-xs btn-danger btn-responsive', method: :post) do
          helper.content_tag(:span, nil, class: 'glyphicon glyphicon-eye-close') +
          helper.content_tag(:span, helper.t('.unpublish', default: helper.t('acts_as_published.actions.unpublish')), class: 'btn-text')
        end
      else
        helper.link_to(link_path, class: 'btn btn-xs btn-success btn-responsive', method: :post) do
          helper.content_tag(:span, nil, class: 'glyphicon glyphicon-eye-open') +
          helper.content_tag(:span, helper.t('.publish', default: helper.t('acts_as_published.actions.publish')), class: 'btn-text')
        end
      end
    end
  end

  def acts_as_list_actions(options = {})
    scope = options[:scope]

    column_options = { as: :acts_as_list }
    column_options[:scope] = scope if scope.present?
    column :acts_as_list_actions, column_options
  end

  private 

  def build_table_data(attribute_name, options = {}, &block)
    options.reverse_merge!(table_column_html_options: default_html_options_for_table_column(attribute_name))
    table_column_html_options = options.delete(:table_column_html_options)

    helper.content_tag(:td, table_column_html_options) do
      if block_given?
        block.call(resource)
      else
        helper.content_tag(:span, display(attribute_name, options), class: 'value')
      end
    end
  end

  def default_html_options_for_table_column(attribute_name)
    { role: attribute_name.to_s.dasherize }
  end
end