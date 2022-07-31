# frozen_string_literal: true

# Modified version of TryStatic, from rack-contrib
# https://github.com/rack/rack-contrib/blob/095edc9df5c98f2e731898edd8bb2f48894a4445/lib/rack/contrib/try_static.rb

# Serve static files under a BUILD_DIR directory:
# - `/` will try to serve your `[BUILD_DIR]/index.html` file
# - `/foo` will try to serve `BUILD_DIR/foo` or `[BUILD_DIR]/foo.html` in that order
# - missing files will try to serve `[BUILD_DIR]/404.html`` or a tiny default 404 page

MIDDLEMAN_BUILD_DIR = "build" # set the same value as config[:build_dir] for Middleman

module Rack
  class TryStatic
    def initialize(app, options)
      @app = app
      @try = ["", *options.delete(:try)]
      @static = ::Rack::Static.new(lambda { [404, {}, []] }, options)
    end

    def call(env)
      orig_path = env["PATH_INFO"]
      found = nil

      @try.each do |path|
        resp = @static.call(env.merge!({"PATH_INFO" => orig_path + path}))
        break if 404 != resp[0] && found = resp
      end

      found or @app.call(env.merge!("PATH_INFO" => orig_path))
    end
  end
end

use Rack::Deflater
use Rack::TryStatic, root: MIDDLEMAN_BUILD_DIR, urls: %w[/], try: [".html", "index.html", "/index.html"]

# Run your own Rack app here or use this one to serve 404 messages:
run lambda{ |env|
  not_found_page = File.expand_path("../#{MIDDLEMAN_BUILD_DIR}/404.html", __FILE__)
  if File.exist?(not_found_page)
    [ 404, { "Content-Type"  => "text/html"}, [File.read(not_found_page)] ]
  else
    [ 404, { "Content-Type"  => "text/html" }, ["404 - page not found"] ]
  end
}
