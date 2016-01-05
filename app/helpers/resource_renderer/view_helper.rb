module ResourceRenderer
  module ViewHelper
    class RenderCollection
      attr_accessor :helper, :collection, :renderer, :renderer_class

      def initialize(collection, resource_class, helper, options = {})
        options.reverse_merge!({ :as => :text })

        renderer_name = options.delete(:as)

        self.renderer_class = get_renderer_class(renderer_name)
        self.collection = collection
        self.helper = helper
        self.renderer = renderer_class.new(collection, resource_class, helper)
        self
      end

      def render_collection(&block)
        renderer.render(&block)
      end

      private

      def get_renderer_class(renderer_name)
        renderer_class_name = "#{renderer_name.to_s.camelize}CollectionRenderer"
        renderer = Object.const_get(renderer_class_name)
        raise DisplayBlockNotDefinedException, "#{renderer.to_s} not defined" unless renderer.is_a?(Class)
        renderer
      end
    end

    class RenderResource
      attr_accessor :helper, :resource, :renderer, :renderer_class

      def initialize(resource, helper, options = {})
        options.reverse_merge!({ :as => :text })

        renderer_name = options.delete(:as)

        self.renderer_class = get_renderer_class(renderer_name)
        self.resource = resource
        self.helper = helper
        self.renderer = renderer_class.new(resource, helper)
        self
      end

      def render(&block)
        renderer.render(&block)
      end

      private

      def get_renderer_class(renderer_name)
        renderer_class_name = "#{renderer_name.to_s.camelize}ResourceRenderer"
        renderer = Object.const_get(renderer_class_name)
        raise DisplayBlockNotDefinedException, "#{renderer.to_s} not defined" unless renderer.is_a?(Class)
        renderer
      end
    end

    def render_resource(resource, options = {}, &block)
      RenderResource.new(resource, self, options).render(&block)
    end

    def render_collection(collection, resource_class, options = {}, &block)
      RenderCollection.new(collection, resource_class, self, options).render_collection(&block)
    end
  end
end