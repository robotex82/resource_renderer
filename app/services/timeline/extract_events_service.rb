require 'timeline/event'

module Timeline
  class ExtractEventsService < Itsf::Services::V2::Service::Base
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

    def initialize_attributes
      @title_method       = :title
      @description_method = :description
      @timestamp_method   = :created_at
    end

    def extract_events
      info 'Extracting Events'
      resources.collect do |resource|
        Event.new(
          title:       resource.send(title_method),
          description: resource.send(description_method),
          happened_at: resource.send(timestamp_method))
      end
    end

    def resources
      @resources || []
    end
  end
end