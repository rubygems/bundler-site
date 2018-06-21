---
title: Gemfile
description: What's inside Gemfile
---

## In Depth

Read the manual for an in-depth discussion of all of the options available in the
<code>Gemfile</code> and how to use them.

<a href="/man/gemfile.5.html" class="btn btn-primary">Gemfile manual</a>

## Gemfiles

Gemfiles require at least one gem source, in the form of the URL for a RubyGems server. Generate a Gemfile with the default rubygems.org source by running <code>bundle init</code>. If you can, use <code>https</code> so your connection to the rubygems.org server will be verified with SSL.

~~~ ruby
source 'https://rubygems.org' do
  # Gems here
end
~~~

Global source lines are a security risk and should not be used as they can lead to gems being installed from unintended sources.

Some gem sources require a username and password. Use
<code>bundle config</code> to set the username and password for any
sources that need it. The command must be run once on each computer that
will install the Gemfile, but this keeps the credentials from being stored
in plain text in version control.

    $ bundle config https://gems.example.com/ user:password

For some sources, like a company Gemfury account, it may be easier to
simply include the credentials in the Gemfile as part of the source URL.

~~~ ruby
source "https://user:password@gems.example.com"
~~~

Credentials in the source URL will take precedence over credentials set
using <code>config</code>.

Declare the gems that you need, including version numbers. Specify versions using the same
syntax that RubyGems supports for dependencies.

~~~ ruby
gem 'nokogiri'
gem 'rails', '3.0.0.beta3'
gem 'rack',  '>=1.0'
gem 'thin',  '~>1.1'
~~~

Most of the version specifiers, like <code>>= 1.0</code>, are self-explanatory.
The specifier <code>~></code> has a special meaning, best shown by example.
<code>~> 2.0.3</code> is identical to <code>>= 2.0.3</code> and <code>< 2.1</code>.
<code>~> 2.1</code> is identical to <code>>= 2.1</code> and <code>< 3.0</code>.
<code>~> 2.2.beta</code> will match prerelease versions like <code>2.2.beta.12</code>.

<a href="http://guides.rubygems.org/patterns/#pessimistic-version-constraint" class="btn btn-primary">RubyGems version specifiers</a>

If a gem's main file is different than the gem name, specify how to require it.

~~~ ruby
gem 'rspec', :require => 'spec'
gem 'sqlite3'
~~~

Specify <code>:require => false</code> to prevent bundler from requiring the gem, but still install it and maintain dependencies.

~~~ ruby
gem 'rspec', :require => false
gem 'sqlite3'
~~~

In order to require gems in your <code>Gemfile</code>, you will need to call
<code>Bundler.require</code> in your application.

<a href="./groups.html" class="btn btn-primary">Learn More: Bundler.require</a>

If some of your gems need to be fetched from a private gem server, this default source can be overridden for those gems.

For a gem server that contains a single gem, it is easiest to use the <code>:source</code> option on that gem.

~~~ ruby
gem 'my_gem', '1.0', :source => 'https://gems.example.com'
~~~

If several gems come from the same server, you can use a <code>source</code> block to group them together.

~~~ ruby
source 'https://gems.example.com' do
  gem 'my_gem', '1.0'
  gem 'another_gem', '1.2.1'
end
~~~

Credentials for gem servers can be specified either in the URL or using
<code>bundle config</code>, as described above.

Git repositories are also valid gem sources, as long as the repo contains one or
more valid gems. Specify what to check out with <code>:tag</code>,
<code>:branch</code>, or <code>:ref</code>. The default is the <code>master</code> branch.

~~~ ruby
gem 'nokogiri', :git => 'https://github.com/tenderlove/nokogiri.git', :branch => '1.4'
~~~

If the git repository does not contain a <code>.gemspec</code> file, bundler
will create a simple one, without any dependencies, executables or C extensions.
This may work for simple gems, but not work for others. If there is no .gemspec,
you probably shouldn't use the gem from git.

<a href="./git.html" class="btn btn-primary">Learn More: Git</a>

If you would like to use an unpacked gem directly from the filesystem, simply set the <code>:path</code> option to the path containing the gem's files.

~~~ ruby
gem 'extracted_library', :path => './vendor/extracted_library'
~~~

If you would like to use multiple local gems directly from the filesystem, you can set a global `path` option to the path containing the gem's files. This will automatically load gemspec files from subdirectories.

~~~ ruby
path 'components' do
  gem 'admin_ui'
  gem 'public_ui'
end
~~~

Dependencies can be placed into groups. Groups can be ignored at install-time (using <code>--without</code>) or required all at once (using <code>Bundler.require</code>).

~~~ ruby
gem 'wirble', :group => :development
gem 'debugger', :group => [:development, :test]

group :test do
  gem 'rspec'
end
~~~

<a href="./groups.html" class="btn btn-primary">Learn More: Groups</a>

You can specify the required version of Ruby in the <code>Gemfile</code> with <code>ruby</code>. If the <code>Gemfile</code> is loaded on a different Ruby version, Bundler will raise an exception with an explanation.

~~~ ruby
ruby '1.9.3'
~~~

What this means is that this app has a dependency to a Ruby VM that is ABI compatible with 1.9.3. If the version check does not match, Bundler will raise an exception. This will ensure the running code matches. You can be more specific with the <code>:engine</code> and <code>:engine_version</code> options.

~~~ ruby
ruby '1.9.3', :engine => 'jruby', :engine_version => '1.6.7'
~~~

<a href="./gemfile_ruby.html" class="btn btn-primary">Learn More: Ruby Directive</a>
