module DocsHelper
  def additional_pages
    %w(bundle.1 gemfile.5).freeze
  end

  def documentation_path(page, version=nil)
    check_single_page("/man#{page}", version) || check_single_page(page, version) || check_single_page(normalize_man_page(page), version)
  end

  def link_to_documentation(page, version=nil)
    link_to page.gsub(/_|-/, " ").gsub(/\.\d+$/, ""), normalized_documentation_path(page, version)
  end

  def link_to_editable_version
    path = current_page.file_descriptor.relative_path.to_s
    if path.start_with?("doc/")
      path.delete_prefix!("doc/")
      path.prepend("doc/bundler/")
      dirname = File.dirname(path)
      basename = File.basename(path, ".html.md").upcase
      path = File.join(dirname, "#{basename}.md")
      link_to_source("rubygems/rubygems", path)
    elsif %r{\Aman/(?<filename>(bundle[_-]|gemfile)[^/]*)\.html} =~ path
      path = "bundler/lib/bundler/man/#{filename}.ronn"
      link_to_source("rubygems/rubygems", path)
    elsif %r{\A(?<version>v\d+\.\d+)/man/(?<filename>(bundle[_-]|gemfile)[^/]*)\.html} =~ path
      if version == current_version
        path = "bundler/lib/bundler/man/#{filename}.ronn"
        link_to_source("rubygems/rubygems", path)
      else
        path = path.sub(version, current_version)
        link_to_latest(path)
      end
    else
      path = File.join "source", path
      link_to_source("rubygems/bundler-site", path)
    end
  end

  def path_exist?(page, version=nil)
    documentation_path("/#{page}.html", version)
  end
  alias_method :normalized_documentation_path, :path_exist?

  def other_commands(primary_commands, version=nil)
    version ||= current_version

    current_man_pages = sitemap.resources.select{ |page| page.path.start_with?("#{version}/man/bundle-") }
    commands_from_man = current_man_pages.map{ |page| strip_man_path_to_page(page.path) } # ex: bundle-config.1

    (commands_from_man - primary_commands + additional_pages).sort do |x,y|
      normalize_man_page(x) <=> normalize_man_page(y)
    end
  end

  def current_visible_version
    current_page.url.scan(/v\d\.\d+/).first || current_version
  end

  def current_page_without_version
    strip_version_from_url(current_page.url)
  end

  # Check if the argument path is a kind of whats_new
  def whats_new?(path)
    path.include?("whats_new")
  end

  private

  def link_to_source(repo, path)
    url = "https://github.com/#{repo}/blob/master/#{path}"
    link_to("Edit this document on GitHub", url) +
      " if you caught an error or noticed something was missing."
  end

  def link_to_latest(path)
    url = "/" + path.sub(/\.html.*/, ".html")
    "This document is obsolete. " +
      link_to("See the latest version of this document", url) +
      " if you caught an error or noticed something was missing, it may be fixed there."
  end

  def strip_version_from_url(url)
    url.sub(/\A\/v\d\.\d+/, "")
  end

  def normalize_man_page(page)
    return unless page

    page.gsub(/\.\d+$/, "").gsub("-", "_")
  end

  def strip_man_path_to_page(path)
    path.match(/man\/(.*)\.html$/)[1]
  end

  def check_single_page(path_part, version)
    path = "/#{version || current_version}#{path_part}"
    sitemap.find_resource_by_path(path) ? path : nil
  end
end
