module GuidesHelper
  def localizable_regex
    /localizable\/(.*)\.(.{2})\.html/
  end

  def additional_guides
     %w(./source/doc/contributing/issues.html.md)
  end

  def guides
    target_version = current_visible_version > "v1.15" ? "" : "#{current_visible_version}/"
    guides = Dir.glob("./source/#{target_version}guides/*")
    target_version = current_visible_version > "v1.15" ? "" : "v1.15/"
    localizable_guides = Dir.glob("./source/localizable/#{target_version}guides/*.en.html.md")
    all_guides = guides + localizable_guides + additional_guides

    guides = all_guides.map do |filename|
      filename = filename.sub(/^\.\/source\//, "").sub(/\.(md|haml)$/, "")
      resource = sitemap.find_resource_by_path(filename)
      next unless resource
      { filename: filename, title: resource.metadata[:page][:title] }
    end.compact

    guides.select { |page| page[:title] }.sort_by { |page| page[:title] }
  end

  def link_to_guide(page, options = {})
    filename = process_localizable(page[:filename])
    link_to page[:title], filename, options
  end

  def current_guide?(filename)
    return "active" if current_page.path == filename
    matched = filename.match(localizable_regex)
    return "" unless matched
    return "active" if current_page.path == "#{matched[1]}.html"
    ""
  end

  private

  def process_localizable(filename)
    matched = filename.match(localizable_regex)
    return "/#{filename}" unless matched

    "/#{matched[1]}.html"
  end
end
