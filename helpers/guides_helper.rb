module GuidesHelper
  LOCALIZABLE_REGEX = /localizable\/(v\d+.\d+\/.*)\.(.{2})\.html/
  ADDITIONAL_GUIDES = %w(./source/doc/contributing/issues.html.md)

  def guides
    guides = Dir.glob("./source/#{current_visible_version}/guides/*")
    localizable_guides = Dir.glob("./source/localizable/#{current_visible_version}/guides/*.en.html.md")
    all_guides = guides + localizable_guides + ADDITIONAL_GUIDES
    all_guides.map! { |md_file| md_file.sub(/^\.\/source\//, '').sub(/\.(md|haml)$/, '') }

    all_guides.map do |filename|
      resource = sitemap.find_resource_by_path(filename)
      next unless resource
      { filename: filename, title: resource.metadata[:page][:title] }
    end.select { |page| page[:title] }.sort_by { |page| page[:title] }
  end

  def link_to_guide(page, options = {})
    filename = process_localizable(page[:filename])
    link_to page[:title], '/' + filename, options
  end

  def current_guide?(filename)
    return 'active' if current_page.path == filename
    matched = filename.match(LOCALIZABLE_REGEX)
    return '' unless matched
    return 'active' if current_page.path == "#{matched[1]}.html"
    ''
  end

  private

  def process_localizable(filename)
    matched = filename.match(LOCALIZABLE_REGEX)
    return "/#{filename}" unless matched

    "/#{matched[1]}.html"
  end
end
