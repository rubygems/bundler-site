---
title: Using Bundler with Rails 3
---

Rails 3 comes with baked in support with bundler.

## Using Bundler with Rails 3

Install Rails as you normally would. Use `sudo` if you would normally use `sudo` to install gems.

``` bash
$ gem install rails
```

<aside class="notes">
<b>Note:</b> We recommend using rvm for dependable Ruby installations, especially if you are switching between different versions of Ruby.
</aside>

Generate a Rails app as usual:

``` bash
$ rails new myapp
$ cd myapp
```

Run the server. Bundler is transparently managing your dependencies!

``` bash
$ rails server
```

Add new dependencies to your Gemfile as you need them.

``` ruby
gem 'nokogiri'
gem 'geokit'
```

If you want a dependency to be loaded only in a certain Rails environment, place 
it in a group named after that Rails environment.
 
``` ruby
group :test do
  gem 'rspec'
  gem 'faker'
end
```
You can place a dependency in multiple groups at once as well:

``` ruby
group :development, :test do
  gem 'wirble'
  gem 'ruby-debug'
end
```

**Learn More:** [Groups](./groups.md)

After adding a dependency, if it is not yet installed, install it

``` bash
$ bundle install
```

<aside class="notes">
<b>Note:</b> This will update all dependencies in your Gemfile to the latest versions that do not conflict with other dependencies.
<aside>
