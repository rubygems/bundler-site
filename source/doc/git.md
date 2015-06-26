---
title: Gems from git repositories
---

## Gems from git repositories

Bundler adds the ability to use gems directly from git repositories. Setting them
up is as easy as adding a gem to your Gemfile. Using the very latest version of a gem
(or even a fork) is just as easy as using an official release.

Because RubyGems lacks the ability to handle gems from git, any gems installed
from a git repository will not show up in `gem list`. They will, however, be available after running `Bundler.setup`.

Specify that a gem should come from a git repository with a `.gemspec` at its root:

~~~ ruby
gem 'nokogiri', :git => 'https://github.com/tenderlove/nokogiri.git'
~~~

If there is no `.gemspec` at the root of a git repository, you must specify a version
that bundler should use when resolving dependencies.

~~~ ruby
gem 'deep_merge', '1.0', :git => 'https://github.com/peritor/deep_merge.git'
~~~

Specify that a git repository containing multiple `.gemspec` files should be treated
as a gem source.

~~~ ruby
git 'https://github.com/rails/rails.git' do
  gem 'railties'
  gem 'action_pack'
  gem 'active_model'
end
~~~

Specify that a git repository should use a particular ref, branch, or tag:

~~~ ruby
:git => 'https://github.com/rails/rails.git', :ref => '4aded'
:git => 'https://github.com/rails/rails.git', :branch => '2-3-stable'
:git => 'https://github.com/rails/rails.git', :tag => 'v2.3.5'
~~~

Specifying a ref, branch, or tag for a git repository inline works exactly the same way:

~~~ ruby
gem 'nokogiri', :git => 'https://github.com/tenderlove/nokogiri.git', :ref => '0eec4'
~~~

Bundler can use HTTP(S), SSH, or git:

~~~ ruby
gem 'nokogiri', :git => 'https://github.com/tenderlove/nokogiri.git'
gem 'nokogiri', :git => 'git@github.com:tenderlove/nokogiri.git'
gem 'nokogiri', :git => 'git://github.com/tenderlove/nokogiri.git'
~~~

If you are getting your gems from a public GitHub repository, you can use the shorthand:

~~~ ruby
gem 'nokogiri', :github => 'tenderlove/nokogiri'
~~~

If the repository name is the same as the GitHub account hosting it, you can omit it

~~~ ruby
gem 'rails', :github => 'rails'
~~~

<aside class="alert alert-info" markdown="1">
**NB:** This shorthand can only be used for public repos in Bundler version 1.x. Use HTTPS for read and write:
</aside>

 ~~~ ruby
gem 'rails', :git => 'https://github.com/rails/rails'
~~~

All of the usual `:git` options apply, like `:branch` and `:ref`.

~~~ruby
gem 'rails', :github => 'rails', :ref => 'a9752dcfd15bcddfe7b6f7126f3a6e0ba5927c56'
~~~

There are analogous shortcuts for Bitbucket (`:bitbucket`) and GitHub Gists (`:gist`).

~~~ ruby
gem 'capistrano-sidekiq', :github => 'seuros/capistrano-sidekiq'
gem 'keystone', :bitbucket => 'musicone/keystone'
~~~

## Custom git sources

The `:github` shortcut used above is one of Bundler's built in git sources. Bundler comes
with shortcuts for `:github`, `:gist`, and `:bitbucket`, but you can
also add your own.

If you're using Github Enterprise, Stash, or just have a custom git setup, create
your own shortcuts by calling `git_source` before you use your custom option.
Here's an example for Stash:

~~~ ruby
git_source(:stash){ |repo_name| "https://stash.corp.acme.pl/\#{repo_name}.git" }
gem 'rails', :stash => 'forks/rails'
~~~

## Security

`http://` and `git://` URLs are insecure. A man-in-the-middle attacker could
tamper with the code as you check it out, and potentially supply you with malicious
code instead of the code you meant to check out. Because the `:github` shortcut
uses a `git://` URL in Bundler 1.x versions, we recommend using using HTTPS URLs
or overriding the `:github` shortcut with your own HTTPS git source.

## Local Git Repos

Bundler also allows you to work against a git repository locally instead of
using the remote version. This can be achieved by setting up a local override:

~~~
bundle config local.GEM_NAME /path/to/local/git/repository
~~~

For example, in order to use a local Rack repository, a developer could call:

~~~
bundle config local.rack ~/Work/git/rack
~~~

and setup the git repo pointing to a branch:

~~~ ruby
gem 'rack', :github => 'rack/rack', :branch => 'master'
~~~

Now instead of checking out the remote git repository, the local override will be
used. Similar to a path source, every time the local git repository changes, the changes
will be automatically picked up by Bundler. This means a commit in the local git
repo will update the revision in the `Gemfile.lock` to the local git repo revision.
This requires the same attention as git submodules. Before pushing to the remote, you
need to ensure the local override was pushed, otherwise you may point to a commit
that only exists in your local machine.

Bundler does many checks to ensure a developer won't work with invalid references.
Particularly, we force a developer to specify a branch in the `Gemfile` in order
to use this feature. If the branch specified in the `Gemfile` and the current
branch in the local git repository do not match, Bundler will abort. This ensures
that a developer is always working against the correct branches, and prevents
accidental locking to a different branch.

Finally, Bundler also ensures that the current revision in the `Gemfile.lock`
exists in the local git repository. By doing this, Bundler forces you to fetch
the latest changes in the remotes.

If you do not want bundler to make these branch checks, you can override it by setting this option:

~~~
bundle config disable_local_branch_check true
~~~
