---
title: Using Bundler with Rubygem gemspecs
---

## Using Bundler with Rubygem gemspecs

If you're creating a gem from scratch, you can use bundler's built in gem skeleton to create a base gem for you to edit.

    $ bundle gem my_gem

This will create a new directory named <code>my_gem</code> with your new gem skeleton.

If you already have a gem with a gemspec, you can generate a Gemfile for your gem.

    $ bundle init

Then, add the following to your new Gemfile

    gemspec

Runtime dependencies in your gemspec are treated like base dependencies, and development dependencies are added by default to the group, <code>:development</code>. You can change that group with the <code>:development_group</code> option

~~~ ruby
gemspec :development_group => :dev
~~~

As well, you can point to a specific gemspec using <code>:path</code>. If your gemspec is in <code>/gemspec/path</code>, use

~~~ ruby
gemspec :path => '/gemspec/path'
~~~

If you have multiple gemspecs in the same directory, specify which one you'd like to reference using <code>:name</code>

~~~ ruby
gemspec :name => 'my_awesome_gem'
~~~

This will use <code>my_awesome_gem.gemspec</code>

That's it! Use bundler when developing your gem, and otherwise, use gemspecs normally!

    $ gem build my_gem.gemspec
