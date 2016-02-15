module ResourceRenderer
  module ResourceRenderer
    class Base
      attr_accessor :helper, :resource

      def initialize(resource, helper)
        @resource, @helper = resource, helper
      end

      def render(&block)
        helper.capture do
          block.call(self)
        end
      end

      def display(attribute_name, options = {}, &block)
        attribute_renderer_name = options.delete(:as) if options.has_key?(:as)
        label = options.delete(:label)
        label ||= extract_label(attribute_name)

        attribute_renderer(attribute_name, attribute_renderer_name, &block).display(attribute_name, label, options, &block)
      end

      def association(*args, &block)
        options = args.extract_options!
        options[:as] = :association
        column(*args, options, &block)
      end

      def resource_class
        @resource_class ||= resource.class
      end

      private

      def attribute_renderer(attribute_name, attribute_renderer_name = nil, &block)
        klass = attribute_renderer_class_for(attribute_name, attribute_renderer_name, &block)
        klass.new(resource, helper)
      end

      def extract_label(attribute_name)
        if resource_class.respond_to?(:human_attribute_name)
          resource_class.human_attribute_name(attribute_name)
        else
          attribute_name.to_s
        end
      end

      def attribute_value(attribute_name)
        attribute_renderer(attribute_name)
      end

      def attribute_renderer_class_for(attribute_name, attribute_renderer_name = nil, &block)
        displayer_type = if block_given?
          :base
        elsif attribute_renderer_name.present?
          attribute_renderer_name
        else
          resource.send(attribute_name).class.name.demodulize.underscore.to_sym
        end
        klass_name = "#{displayer_type}_renderer".camelize
        klass = begin
          Object.const_get(klass_name) # rescue GenericRenderer
        rescue NameError => e
          Rails.logger.warn "Resource Renderer: #{e.message}. Using GenericRenderer instead"
          GenericRenderer
        end
        # klass = if Object.const_defined?(klass_name)
        #   Object.const_get(klass_name)
        # else
        #   GenericRenderer
        # end
        unless klass.is_a?(Class)
          raise DisplayerNotDefinedException, "#{klass.to_s} not defined"
        end
        return klass
      end
    end
  end
end
