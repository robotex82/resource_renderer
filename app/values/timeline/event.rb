module Timeline
  class Event
    attr_accessor :title, :description, :happened_at

    def initialize(attributes)
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def title
      I18n.t("classes.#{self.class.name.underscore}")
    end

    def description
      self.inspect
    end

    def <=>(other)
      happened_at <=> other.happened_at
    end
  end
end