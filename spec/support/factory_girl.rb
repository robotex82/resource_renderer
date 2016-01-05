FactoryGirl.definition_file_paths += Itsf::Backend::Configuration.backend_engines.collect{ |backend_engine| backend_engine.name.gsub('::Backend', '').constantize }.collect { |engine| File.join(engine.root, *%w(spec factories)) }
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end