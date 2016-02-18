module ResourceRenderer
  module CollectionRenderer
    class Base
      attr_accessor :helper, :collection, :resource_class, :options

      def initialize(collection, resource_class, helper, options = {})
        @collection, @resource_class, @helper, @options = collection, resource_class, helper, options
      end

      def render(&block)
        helper.capture do
          render_collection(&block)
        end
      end

      def association(*args, &block)
        options = args.extract_options!
        options[:as] = :association
        column(*args, options, &block)
      end
      
      private

      def render_collection(&block)
        collection.collect do |resource|
          renderer_class.new(resource, helper).render(&block)
        end.join.html_safe
      end

      def renderer_class
        @renderer_class ||= get_renderer_class
      end

      def get_renderer_class
        renderer = Object.const_get(renderer_class_name)
        raise DisplayBlockNotDefinedException, "#{renderer.to_s} not defined" unless renderer.is_a?(Class)
        renderer
      end

      def renderer_class_name
        self.class.name.gsub('Collection', 'Resource')
      end
    end
  end
end
