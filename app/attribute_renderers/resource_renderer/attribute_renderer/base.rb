module ResourceRenderer
  module AttributeRenderer
    class Base
      attr_accessor :model, :helper
      alias_method :h, :helper
      alias_method :resource, :model

      def initialize(model, helper)
        @model, @helper = model, helper
      end

      def display(attribute_name, label, options = {}, &block)
        helper.capture do
          if block_given?
            block.call(resource)
          else
            "#{value_for_attribute(attribute_name)}"
          end
        end
      end

      private

      def value_for_attribute(attribute_name)
        model.send(attribute_name)
      end
    end
  end
end
