# Gem install
bundle check || bundle install
# run tests
bundle exec rspec
# Run our server
bundle exec puma -C config/puma.rb