# Include lib files
Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each {|file| require file }

# Browser will reload changed pages automatically.
activate :livereload

###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

# Make documentation for the latest version available at the top level, too.
# Any pages with names that conflict with files already at the top level will be skipped.
ready do
  sitemap.resources.each do |page|
    if page.path.start_with? 'v1.5/'
      proxy_path = page.path['v1.5/'.length..-1]
      proxy proxy_path, page.path if sitemap.find_resource_by_path(proxy_path).nil?
    end
  end
end

###
# Helpers
###
Dir[File.dirname(__FILE__) + '/helpers/**/*.rb'].each {|file| require file }


set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
