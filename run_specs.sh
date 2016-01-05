  #! /bin/bash
  gem install bundler
  bundle
  cd spec/dummy && rake db:migrate RAILS_ENV=test && cd ../..
  guard