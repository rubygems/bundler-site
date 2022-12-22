module DocsHelper
  def additional_pages
    %w(bundle.1 gemfile.5).freeze
  end

  def documentation_path(page, version=nil)
    check_single_page("/man/#{page}.html", version) || check_single_page("/#{page}.html", version) ||
    check_single_page("/#{normalize_man_page(page)}.html", version)
  end

  def link_to_documentation(page, version=nil)
    link_to page.gsub(/_|-/, " ").gsub(/\.\d+$/, ""), documentation_path(page, version)
  end

  def link_to_editable_version
    editable = true
    path = current_page.file_descriptor.relative_path.to_s
    repo =
      if path.start_with?("doc/")
        path = "bundler/#{path}"
        "rubygems/rubygems"
      elsif %r{\A(?<version>v\d+\.\d+)/man/(?<filename>(bundle[_-]|gemfile)[^/]*)\.html} =~ path
        if version == current_version
          path = "bundler/lib/bundler/man/#{filename}.ronn"
        else
          editable = false
        end
        "rubygems/rubygems"
      else
        path = File.join "source", path
        "rubygems/bundler-site"
      end

    if editable
      url = "https://github.com/#{repo}/blob/master/#{path}"
      link_to("Edit this document on GitHub", url) +
        " if you caught an error or noticed something was missing."
    else
      url = "/" + path.sub(version, current_version).sub(/\.html.*/, ".html")
      "This document is obsolete. " +
        link_to("See the latest version of this document", url) +
        " if you caught an error or noticed something was missing, it may be fixed there."
    end
  end

  def path_exist?(page, version=nil)
    documentation_path(page, version)
  end

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

  def strip_version_from_url(url)
    url.scan(/v\d\.\d+\/(.*).html/)&.first&.first || url
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
