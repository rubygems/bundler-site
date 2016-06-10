Dir.glob(File.expand_path('../lib/config/*.rb', __FILE__), &method(:require))

activate :syntax
activate :i18n
activate :sprockets
set :markdown_engine, :kramdown

# Markdown extentions
set :markdown,
    autolink: true,
    fenced_code_blocks: true,
    footnotes: true,
    gh_codeblock: true,
    highlight: true,
    no_intra_emphasis: true,
    quote: true,
    smartypants: true,
    strikethrough: true,
    superscript: true,
    tables: true

config[:versions] = `rake versions`.split
config[:current_version] = config[:versions].last

# Make documentation for the latest version available at the top level, too.
# Any pages with names that conflict with files already at the top level will be skipped.
Dir.glob("./source/#{config[:current_version]}/**/*").select{ |f| !File.directory? f }.each do |file_path|
  file_path = file_path[0..-6] if file_path[-5..-1] == '.haml'

  page_path = file_path["./source/".length..-1]
  proxy_path = file_path["./source/#{config[:current_version]}/".length..-1]

  proxy proxy_path, page_path unless file_exist?(proxy_path)
end

page '/sponsors.html', layout: :compatibility_layout
page '/older_versions.html', layout: :guides_layout
page '/compatibility.html', layout: :commands_layout
page /\/v(.*)\/(?!bundle_|commands|docs)(.*)/, layout: :guides_layout
page /\/v(.*)\/bundle_(.*)/, layout: :commands_layout
page /\/v(.*)\/commands\.html/, layout: :commands_layout

page '/sitemap.xml', layout: false

###
# Helpers
###
Dir.glob(File.expand_path('../helpers/**/*.rb', __FILE__), &method(:require))
helpers CommandReferenceHelper
helpers ConfigHelper
helpers DocsHelper

set :javascript_dir, 'javascripts'
set :css_dir, 'stylesheets'
set :images_dir, 'images'

activate :blog do |blog|
  blog.name = 'blog'
  blog.prefix = 'blog'
  blog.permalink = '{year}/{month}/{day}/{title}.html'
  blog.layout = 'blog_layout'

  blog.calendar_template = 'blog/calendar.html'
  blog.year_link = "{year}/index.html"
  blog.month_link = "{year}/{month}/index.html"
  blog.day_link = "{year}/{month}/{day}/index.html"
end

page "/blog/feed.xml", layout: false

configure :development do
  activate :livereload
end

configure :build do
  activate :minify_html
  activate :minify_css
  activate :minify_javascript
end
