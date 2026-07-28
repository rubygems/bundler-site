source "https://rubygems.org"
ruby File.read(File.expand_path("../.ruby-version", __FILE__)).strip

# Static site generator
gem "middleman", "~> 4.6"
## Extensions
gem "middleman-syntax"

## Template engines
gem "builder"

# Rake tasks
gem "rake"

group :development do
  gem "rubocop"
  gem "rubocop-rake", require: false
end
