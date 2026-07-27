source "https://rubygems.org"
ruby File.read(File.expand_path("../.ruby-version", __FILE__)).strip

# Static site generator
gem "middleman", "~> 4.6"
## Extensions
gem "middleman-search", github: "tnir/middleman-search", branch: "edge" # https://github.com/manastech/middleman-search/pull/39
gem "middleman-syntax"

## Template engines
gem "builder"
gem "haml", "~> 7.2"
gem "kramdown-parser-gfm"

# Rake tasks
gem "rake"

group :development do
  gem "irb"
  gem "pry-byebug"

  gem "haml_lint", "~> 0.73"
  gem "rubocop"
  gem "rubocop-rake", require: false
end
