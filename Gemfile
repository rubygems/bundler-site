source "https://rubygems.org"
ruby File.read(File.expand_path("../.ruby-version", __FILE__)).strip

# Static site generator
## Includes https://github.com/middleman/middleman/pull/2565, https://github.com/middleman/middleman/pull/2571, https://github.com/middleman/middleman/pull/2588
gem "middleman", github: "middleman/middleman", ref: "50f76c2984c4f82b243b0a5e3f860aeaf63e07d5"
## Extensions
gem "middleman-blog"
gem "middleman-search", github: "tnir/middleman-search", branch: "edge" # https://github.com/manastech/middleman-search/pull/39
gem "middleman-syntax"

## Template engines
gem "builder"
gem "haml", "~> 5.2.2"
gem "kramdown"

# Rake tasks
gem "rake"
## To retrieve a list of contributors from GitHub
gem "faraday-retry", "~> 2.0"
gem "octokit", "~> 6.0"
## To generate ERB files from ronn files from rubygems/rubygems
gem "ronn-ng", github: "apjanke/ronn-ng"
## To strip (man:strip_pages)
gem "nokogiri", "~> 1.13"

group :development do
  gem "pry"
  gem "pry-byebug"

  gem "haml_lint", "~> 0.43"
  gem "rubocop"
  gem "rubocop-rake", require: false
end
