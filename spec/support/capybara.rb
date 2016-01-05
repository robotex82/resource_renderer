require 'capybara/rspec'

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
end