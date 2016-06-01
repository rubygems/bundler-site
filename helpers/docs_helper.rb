module DocsHelper
  def documentation_path(page, version=nil)
    path = "/#{version || current_version}/#{page}.html"

    return nil unless sitemap.find_resource_by_path(path)
    path
  end

  def link_to_documentation(page, version=nil)
    link_to page.gsub('_', ' '), documentation_path(page, version)
  end

  def path_exist?(page, version=nil)
    documentation_path(page, version)
  end

  def other_commands(primary_commands, version=nil)
    version ||= current_version

    current_pages = sitemap.resources.select do |page|
      page.path.start_with?("#{version}/bundle_")
    end

    commands = current_pages.map{ |page| page.path[(version.length + 1)..-6] }

    (commands - primary_commands).sort
  end

  def current_visible_version
    current_page.url.scan(/v\d\.\d+/).first || current_version
  end

  def current_page_without_version
    current_page.url.scan(/v\d\.\d+\/(.*).html/)&.first&.first
  end
end
