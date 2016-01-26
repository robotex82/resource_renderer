require 'timeline/event'

module Timeline
  class ExtractEventsService < Itsf::Services::V2::Service::Base
    # class Event
    #   attr_accessor :title, :description, :happened_at

    #   def initialize(attributes)
    #     attributes.each do |name, value|
    #       send("#{name}=", value)
    #     end
    #   end
    # end

    class Response < Itsf::Services::V2::Response::Base
      attr_accessor :events
    end

    attr_accessor :resources, :title_method, :description_method, :timestamp_method

    def do_work
      return response unless valid?
      response.events = extract_events
      respond
    end

    private

    def extract_events
      info 'Extracting Events'
      resources.collect { |resource| Event.new(title: resource.send(title_method), description: resource.send(description_method), happened_at: resource.send(timestamp_method)) }
    end

    def resources
      @resources || []
    end
  end
end