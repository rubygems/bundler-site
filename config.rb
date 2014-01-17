activate :syntax
set :markdown_engine, :kramdown

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
Dir.glob(File.expand_path("../helpers/**/*.rb", __FILE__), &method(:require))

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :development do
  activate :livereload
end

configure :build do
  activate :minify_css
end
