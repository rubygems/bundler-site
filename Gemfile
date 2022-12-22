source "https://rubygems.org"
ruby File.read(File.expand_path("../.ruby-version", __FILE__)).strip

# Static site generator
## Includes https://github.com/middleman/middleman/pull/2565, https://github.com/middleman/middleman/pull/2571
gem "middleman", github: "middleman/middleman", ref: "038f4f606ff6cfc75cbe5c8690c5eae2e34f78f3"
## Extensions
gem "middleman-blog"
gem "middleman-search", github: "deivid-rodriguez/middleman-search", branch: "workarea-commerce-master"
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
gem "ronn"
## To strip (man:strip_pages)
gem "nokogiri", "~> 1.13"

group :development do
  gem "pry"
  gem "pry-byebug"

  gem "haml_lint", "~> 0.43"
  gem "rubocop"
end
