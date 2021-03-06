class TableCollectionRenderer < ResourceRenderer::CollectionRenderer::Base
  class Header
    attr_accessor :controller, :helper, :view_context, :resource_class
    alias_method :h, :helper

    def initialize(resource_class, helper)
      @resource_class, @helper = resource_class, helper
      @controller = helper.instance_variable_get('@_controller')
      @view_context = @controller.view_context
    end

    def render(&block)
      helper.content_tag(:tr) do
        block.call(self)
      end
    end

    def association(*args, &block)
      options = args.extract_options!
      options[:as] = :association   
      column(*args, options, &block)
    end

    def column(attribute_name, options = {})
      return column_with_sorting(attribute_name, options) if ransack_query.present? && options.has_key?(:sortable) && options[:sortable] != false

      label = if @resource_class.respond_to?(:human_attribute_name)
        @resource_class.human_attribute_name(attribute_name)
      else
        attribute_name
      end
      helper.content_tag(:th, label, id: "table-header-#{attribute_name}")
    end

    def columns(*args)
      _ = args.extract_options!
      columns = *args || resource_class.attribute_names
      columns.collect do |name|
        column name
      end.join.html_safe
    end

    def timestamps
      column(:created_at, sortable: true) +
      column(:updated_at, sortable: true)
    end

    def userstamps
      column(:creator, sortable: true) +
      column(:updater, sortable: true)
    end
    def acts_as_published_actions
      column(:acts_as_published_actions)
    end

    def acts_as_list_actions(options = {})
      column(:acts_as_list_actions)
    end

    def awesome_nested_set_actions(options = {})
      column(:awesome_nested_set_actions)
    end
    private

    def column_with_sorting(attribute_name, options = {})  
      sort_by = case options[:sortable]
      when TrueClass
        attribute_name
      when Symbol, String, Array
        options[:sortable]
      end


      label = if @resource_class.respond_to?(:human_attribute_name)
        @resource_class.human_attribute_name(attribute_name)
      else
        attribute_name
      end

      sort_link = helper.sort_link(ransack_query, sort_by, label)

      helper.content_tag(:th, sort_link, id: "table-header-#{attribute_name}")
    end

    def ransack_query
      view_context.instance_variable_get('@q')
    end
  end

  attr_accessor :table_html_options

  def initialize(*args)
    super
    options.reverse_merge(table_html_options: {})
    self.table_html_options = options.delete(:table_html_options)
  end

  def render(&block)
    helper.capture do
      helper.content_tag(:table, table_html_options) do
        helper.concat render_header(&block)
        helper.concat render_collection(&block)
      end
    end
  end

  private

  def render_header(&block)
    header_renderer.render(&block)
  end

  def header_renderer
    Header.new(resource_class, helper)
  end
end
