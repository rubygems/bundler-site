---
title: Using Bundler with Rails
---

> Rails 3 and up comes with baked in support for bundler.

## Using Bundler with Rails

Install Rails as you normally would. Use `sudo` if you would normally use `sudo` to install gems.

~~~
$ gem install rails
~~~

**Note:** We recommend using rvm for dependable Ruby installations, especially if you are switching between different versions of Ruby.
{:.alert .alert-info}

Generate a Rails app as usual:

~~~
$ rails new myapp
$ cd myapp
~~~

Run the server. Bundler is transparently managing your dependencies!

~~~
$ rails server
~~~

Add new dependencies to your Gemfile as you need them.

~~~ ruby
gem 'nokogiri'
gem 'geokit'
~~~

If you want a dependency to be loaded only in a certain Rails environment, place
it in a group named after that Rails environment.

~~~ ruby
group :test do
  gem 'rspec'
  gem 'faker'
end
~~~

You can place a dependency in multiple groups at once as well:

~~~ ruby
group :development, :test do
  gem 'wirble'
  gem 'ruby-debug'
end
~~~

[Learn More: Groups](./groups.html)

After adding a dependency, if it is not yet installed, install it:

~~~
$ bundle install
~~~

**Note:** This will update all dependencies in your Gemfile to the latest
  versions that do not conflict with other dependencies.
{:.alert .alert-info}
