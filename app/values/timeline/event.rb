module Timeline
  class Event
    attr_accessor :title, :description, :happened_at

    def initialize(attributes)
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def <=>(other)
      happened_at <=> other.happened_at
    end
  end
end