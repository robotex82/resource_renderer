class DurationRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, label, options = {}, &block)
    return  h.capture { block.call(resource) } if block_given?

    options.reverse_merge!(input_unit: :seconds)
    input_unit = options.delete(:input_unit)

    input_duration = value_for_attribute(attribute_name)
    seconds = duration_in_seconds(input_duration, input_unit)

    html_attributes = {

    }

    helper.capture do
      h.content_tag(:span, html_attributes) { humanize(seconds) }
    end
  end

  private

  def duration_in_seconds(input_duration, input_unit)
    case input_unit
    when :seconds
      input_duration
    when :minutes
      input_duration * 60
    when :hours
      input_duration * 3600
    when :days
      input_duration * 86400
    when :weeks
      input_duration * 604800
    end
  end

  def humanize(seconds)
    [[60, :seconds], [60, :minutes], [24, :hours], [1000, :days]].inject([]){ |s, (count, name)|
      if seconds > 0
        seconds, n = seconds.divmod(count)
        translated_name = I18n.t("datetime.distance_in_words.x_#{name}", count: n.to_i)
        s.unshift translated_name
      end
      s
    }.join(' ')
  end
end