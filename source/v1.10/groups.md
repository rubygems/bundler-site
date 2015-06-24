---
title: Using Groups
---

## Using Groups

Grouping your dependencies allows you to perform operations on an entire group.

~~~ruby
# These gems are in the :default group
gem 'nokogiri'
gem 'sinatra'

# Add a gem to a group
gem 'wirble', :group => :development

# These gems are in the :test group
group :test do
  gem 'faker'
  gem 'rspec'
end

# You can specify multiple groups for gems
groups :test, :development do
  gem 'capybara'
  gem 'rspec-rails'
end

gem 'cucumber', :group => [cucumber, :test]
~~~

You can exclude gems to be installed by using the  `--without` option followed by the group(s):

~~~
$ bundle install `--without` test development
~~~

Require the gems in particular groups, noting that gems outside of a named group are in the `:default` group

~~~ruby
Bundler.require(:default, :development)
~~~

Require the default gems, plus the gems in a group named the same as the current Rails environment

~~~ruby
Bundler.require(:default, Rails.env)
~~~

Restrict the groups of gems that you want to add to the load path. Only gems in these groups can be required.

~~~ruby
require 'rubygems'
require 'bundler'
Bundler.setup(:default, :ci)
require 'nokogiri'
~~~
