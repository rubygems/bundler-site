# bundler.io
bundler.io is intended to serve as a convenient source for documentation on the [bundler](https://github.com/bundler/bundler) gem. 

The site bundler.io is a static site generated using [Middleman](http://middlemanapp.com/).

[Bundler's manual pages](https://github.com/bundler/bundler/tree/master/man) document much of its functionality and serve as an important part of the site. They are included via the **Rakefile**.

## Basic Middleman Commands

Run a local development web server:

    bundle exec middleman server

This will start a local web server running at: *http://localhost:4567*. It will serve the site as it exists in **/source**.

Note: the development server will automatically reload pages when they or there associated stylesheets are modified. This feature is enabled in **config.rb**.

Build the site:

    bundle exec middleman build

This will use the files in **/source** to generate a static site in **/build**.


Using the **--clean** flag like so:

	bundle exec middleman build --clean

will also build the site but will also remove from **/build** any files that aren't produced by the current state of **/source**.
