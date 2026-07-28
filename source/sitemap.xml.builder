xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc "https://bundler.io"
    xml.lastmod Time.now.utc.iso8601
    xml.changefreq "weekly"
    xml.priority 1.0
  end
end
