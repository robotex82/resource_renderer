require_dependency 'resource_renderer/resource_renderer/base'

class AttributeTableResourceRenderer < ResourceRenderer::ResourceRenderer::Base
  def row(attribute_name, options = {}, &block)
    build_table_row(attribute_name, options, &block)
  end

  def render(&block)
    helper.content_tag(:table, table_html_options) do
      block.call(self)
    end
  end

  private 

  def table_html_options
    nil
  end

  def build_table_row(attribute_name, options = {}, &block)
    options.reverse_merge!(table_row_html_options: default_html_options_for_table_row(attribute_name))
    table_row_html_options = options.delete(:table_row_html_options)

    helper.content_tag(:tr, table_row_html_options) do
      helper.content_tag(:th) do
        helper.content_tag(:span, extract_label(attribute_name), class: 'key')
      end +
      helper.content_tag(:td) do
        if block_given?
          block.call(resource)
        else
          helper.content_tag(:span, display(attribute_name, options), class: 'value')
        end
      end
    end
  end

  def default_html_options_for_table_row(attribute_name)
    { role: attribute_name.to_s.dasherize }
  end
end