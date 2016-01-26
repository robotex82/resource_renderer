class TimelineResourceRenderer < ResourceRenderer::ResourceRenderer::Base
  def event(attribute_name, options = {}, &block)
    build_event(attribute_name, options, &block)
  end

  private

  def build_event(attribute_name, options, &block)
    options.reverse_merge!(title_method: :to_s, description_method: :inspect, timestamp_method: :created_at)
    @timestamp_method = options.delete(:timestamp_method)
    @title_method = options.delete(:title_method)
    @description_method = options.delete(:description_method)

    event = resource.is_a?(Timeline::Event) ? resource : extract_event
    

    helper.content_tag(:div, class: 'timeline-block') do
      helper.content_tag(:div, class: 'timeline-icon') do
      end +
      helper.content_tag(:div, class: 'timeline-content') do
        helper.content_tag(:div, class: 'timeline-body') do
          helper.content_tag(:div, event.title, class: 'timeline-title') + 
          helper.content_tag(:div, event.description, class: 'timeline-description')
        end + 
        helper.content_tag(:div, I18n.l(event.happened_at), class: 'timeline-date')
      end
    end
  end

  def extract_event
    Timeline::ExtractEventsService.call(resources: [resource], 
                                        title_method: @title_method,
                                        description_method: @description_method,
                                        timestamp_method: @timestamp_method).events.first
  end
end