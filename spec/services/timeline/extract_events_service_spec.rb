require 'rails_helper'

module Timeline
  RSpec.describe ExtractEventsService do
    before(:each) do
      @resources = 5.times.collect { |i| OpenStruct.new name: "Event #{6 - i}", happened_at: i.hours.ago }
    end

    it { expect(ExtractEventsService.call(resources: @resources).events).to be_a(Array) }
    it { expect(ExtractEventsService.call(resources: @resources).events.size).to eq(5) }
    it { expect(ExtractEventsService.call(resources: @resources).events.first).to respond_to(:title) }
    it { expect(ExtractEventsService.call(resources: @resources).events.first).to respond_to(:happened_at) }
  end
end