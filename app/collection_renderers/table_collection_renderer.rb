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
      # return column_with_sorting(attribute_name, options) if Itsf::Backend.features?(:ransack) && options.has_key?(:sortable) && options[:sortable] != false
      return column_with_sorting(attribute_name, options) if options.has_key?(:sortable) && options[:sortable] != false

      label = if @resource_class.respond_to?(:human_attribute_name)
        @resource_class.human_attribute_name(attribute_name)
      else
        attribute_name
      end
      helper.content_tag(:th, label)
    end

    def timestamps
      column(:created_at, sortable: true) +
      column(:updated_at, sortable: true)
    end

    def acts_as_published_actions
      column(:acts_as_published_actions)
    end

    def acts_as_list_actions(options = {})
      column(:acts_as_published_actions)
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
      
      helper.content_tag(:th, sort_link)
    end

    def ransack_query
      view_context.instance_variable_get('@q')
    end
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

  def table_html_options
    nil
  end

  def render_header(&block)
    header_renderer.render(&block)
  end

  def header_renderer
    Header.new(resource_class, helper)
  end
end
