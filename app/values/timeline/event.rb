module Timeline
  class Event
    attr_accessor :title, :description, :happened_at

    def initialize(attributes)
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
  end
end