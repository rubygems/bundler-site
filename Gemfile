source "https://rubygems.org"
ruby File.read(File.expand_path("../.ruby-version", __FILE__)).strip

# Static site generator
gem "middleman", "~> 4.6"
## Extensions
gem "middleman-blog", github: "middleman/middleman-blog"
gem "middleman-search", github: "tnir/middleman-search", branch: "edge" # https://github.com/manastech/middleman-search/pull/39
gem "middleman-syntax"

## Template engines
gem "builder"
gem "haml", "~> 6.3"
gem "kramdown-parser-gfm"

# Rake tasks
gem "rake"
## To retrieve a list of contributors from GitHub
gem "faraday-retry", "~> 2.3"
gem "octokit", "~> 10.0"
## To generate ERB files from ronn files from rubygems/rubygems
gem "nronn"
## To strip (man:strip_pages)
gem "nokogiri", "~> 1.18"

group :development do
  gem "irb"
  gem "pry-byebug"

  gem "haml_lint", "~> 0.67"
  gem "rubocop"
  gem "rubocop-rake", require: false
end
