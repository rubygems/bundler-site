---
title: Using Bundler with Rubygem gemspecs
---

## Using Bundler with Rubygem gemspecs

If you're creating a gem from scratch, you can use bundler's built in gem skeleton to create a base gem for you to edit.

~~~
$ bundle gem my_gem
~~~

**Note:** This will create a new directory named `my_gem` with your new gem skeleton.
{:.alert .alert-info}

If you already have a gem with a gemspec, you can generate a Gemfile for your gem.

~~~
$ bundle init
~~~

Then, add the following to your new Gemfile:

~~~ ruby
gemspec
~~~

Runtime dependencies in your gemspec are treated like base dependencies, and development dependencies are added by default to the group, `:development`. You can change that group with the `:development_group` option

~~~ ruby
gemspec :development_group => :dev
~~~

As well, you can point to a specific gemspec using `:path`. If your gemspec is in `/gemspec/path`, use
~~~ ruby
gemspec :path => '/gemspec/path'
~~~
If you have multiple gemspecs in the same directory, specify which one you'd like to reference using `:name`

~~~ ruby
gemspec :name => 'my_awesome_gem'
~~~

This will use `my_awesome_gem.gemspec`
{:.alert .alert-info}

That's it! Use bundler when developing your gem, and otherwise, use gemspecs normally!

~~~
$ gem build my_gem.gemspec
~~~
