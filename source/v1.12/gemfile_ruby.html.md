---
title: Specifying a Ruby Version
---

## Specifying a Ruby Version

Like gems, developers can setup a dependency on Ruby. This makes your app fail faster in case you depend on specific features in a Ruby VM. This way, the Ruby VM on your deployment server will match your local one. You can do this by using the <code>ruby</code> directive in the <code>Gemfile</code>:

~~~ ruby
ruby 'RUBY_VERSION', :engine => 'ENGINE', :engine_version => 'ENGINE_VERSION',
  :patchlevel => 'RUBY_PATCHLEVEL'
~~~

If you wanted to use JRuby 1.6.7 using Ruby 1.9.3, you would simply do the following:

~~~ ruby
ruby '1.9.3', :engine => 'jruby', :engine_version => '1.6.7'
~~~

It's also possible to restrict the patchlevel of the Ruby used by doing the following:

~~~ ruby
ruby '1.9.3', :patchlevel => '448'
~~~

Bundler will make checks against the current running Ruby VM to make sure it matches what is specified in the <code>Gemfile</code>. If things don't match, Bundler will raise an Exception explaining what doesn't match.

    Your Ruby version is 1.8.7, but your Gemfile specified 1.9.3

Both <code>:engine</code> and <code>:engine_version</code> are optional. When these options are omitted, this means the app is compatible with a particular Ruby ABI but the engine is irrelevant. When <code>:engine</code> is used, <code>:engine_version</code> must also be specified.

Using the <code>platform</code> command with the <code>--ruby</code> flag, you can see what <code>ruby</code> directive is specified in the <code>Gemfile</code>.

    ruby 1.9.3 (jruby 1.6.7)

<a href="/bundle_platform.html" class="btn btn-primary">Learn More: bundle platform</a>

In the <code>ruby</code> directive, <code>:patchlevel</code> is optional, as patchlevel releases are usually compatible and include important security fixes. The patchlevel option checks the <code>RUBY_PATCHLEVEL</code> constant, and if not specified then bundler will simply ignore it.

Version operators for specifying a Ruby version are also available. The set of supported version operators is that of Rubygems (<code>gem</code> version operators). (ie. <code><</code>, <code>></code>, <code><=</code>, <code>>=</code>, <code>~></code>, <code>=</code>)

~~~ ruby
ruby '~> 2.3.0'
~~~

<a href="http://guides.rubygems.org/patterns/#declaring-dependencies" class="btn btn-primary">Learn More: Version Operators</a>
