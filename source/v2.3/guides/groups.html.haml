---
title: How to manage groups of gems
---
.container.guide
  %h2 How to manage groups of gems

  .contents
    .bullet
      .description
        Grouping your dependencies allows you
        to perform operations on the entire
        group.
      :code
        # lang: ruby
        # These gems are in the :default group
        gem 'nokogiri'
        gem 'sinatra'

        gem 'wirble', group: :development

        group :test do
          gem 'faker'
          gem 'rspec'
        end

        group :test, :development do
          gem 'capybara'
          gem 'rspec-rails'
        end

        gem 'cucumber', group: [:cucumber, :test]
    .bullet
      .description
        Configure bundler so that subsequent
        `bundle install` invokations will install
        all gems, except those in the listed
        groups. Gems in at least one non-excluded
        group will still be installed.
      :code
        $ bundle config set --local without test development
    .bullet
      .description
        Require the gems in particular groups,
        noting that gems outside of a named group
        are in the :default group
      :code
        # lang: ruby
        Bundler.require(:default, :development)
    .bullet
      .description
        Require the default gems, plus the gems
        in a group named the same as the current
        Rails environment
      :code
        # lang: ruby
        Bundler.require(:default, Rails.env)
    .bullet
      .description
        Restrict the groups of gems that you
        want to add to the load path. Only gems
        in these groups will be require'able.
        Note though that `Bundler.setup` can be
        called only once, all subsequent calls are
        no-op. In particular, since running a
        script through `bundle exec` already calls
        `Bundler.setup`, any later calls inside
        your user code will be ignored. In order to
        control the groups that are loaded by
        `bundle exec` you can use the `BUNDLE_WITH`
        and `BUNDLE_WITHOUT` configurations.
      :code
        # lang: ruby
        require 'rubygems'
        require 'bundler'
        Bundler.setup(:default, :ci)
        require 'nokogiri'
      = link_to 'Learn More: Bundler.setup', './bundler_setup.html', class: 'btn btn-primary'


    %h2#optional-groups
      Optional groups and <code>BUNDLE_WITH</code>
    .bullet
      .description
      Mark a group as optional using <code>group :name, optional: true do</code> and then opt
      into installing an optional group with <code>bundle config set --local with name</code>.

    %h2#grouping-your-dependencies
      Grouping your dependencies
    .bullet
      .description
        You'll sometimes have groups of gems that only make sense in particular environments.
        For instance, you might develop your app (at an early stage) using SQLite but deploy it
        using <code>mysql2</code> or <code>pg</code>. In this example, you might not have MySQL
        or Postgres installed on your development machine and want bundler to skip it.

        To do this, you can group your dependencies:

      :code
        # lang: ruby
        source 'https://rubygems.org'

        gem 'rails', '3.2.2'
        gem 'rack-cache', require: 'rack/cache'
        gem 'nokogiri', '~> 1.4.2'

        group :development do
          gem 'sqlite3'
        end

        group :production do
          gem 'pg'
        end
    .bullet
      .description
        Now, in development, you can instruct bundler to skip the <code>production</code> group:

      :code
        $ bundle config set --local without production
    .bullet
      .description
        Bundler stores the flag in <code>APP_ROOT/.bundle/config</code> and the
        next time you run `bundle install`, it will skip production gems.
        Similarly, when you require `bundler/setup`, Bundler will ignore gems in
        these groups. You can see all of the settings that Bundler saved there
        by running <code>bundle config</code>, which will also print out global
        settings (stored in <code>~/.bundle/config</code>) and settings set via
        environment variables.  For more information on configuring Bundler,
        please see: #{link_to_documentation "bundle_config"}

    .bullet
      %p.description
        You can also specify which groups to automatically require through the parameters to
        <code>Bundler.require</code>. The <code>:default</code> group includes all gems not
        listed under any group. If you call <code>Bundler.require(:default, :development)</code>,
        bundler will <code>require</code> all the gems in the <code>:default</code> group as
        well as the gems in the <code>:development</code> group.

      %p.description
        By default, a Rails generated app calls <code>Bundler.require(:default,
        Rails.env)</code> in your <code>application.rb</code>, which links the groups in your
        <code>Gemfile</code> to the Rails environment. If you use other groups (not linked to a
        Rails environment), you can add them to the call to <code>Bundler.require</code> if you
        want them to be automatically required.

      %p.description
        Remember that you can always leave groups of gems out of <code>Bundler.require</code>
        and then require them manually using Ruby's <code>require</code> at the appropriate
        place in your app. You might do this because requiring a certain gem takes some time
        and you don't need it every time you boot your application.
