module DocsHelper
  ADDITIONAL_PAGES = %w(bundle.1 gemfile.5).freeze
  
  def documentation_path(page, version=nil)
    check_single_page("/man/#{page}.html", version) || check_single_page("/#{page}.html", version) ||
    check_single_page("/#{normalize_man_page(page)}.html", version)
  end
  
  def link_to_documentation(page, version=nil)
    link_to page.gsub(/_|-/, ' ').gsub(/\.\d+$/, ''), documentation_path(page, version)
  end
  
  def link_to_editable_version
    path = current_page.file_descriptor.relative_path.to_s
    repo = 
      if path.start_with?('doc/')
        path = "bundler/#{path}"
        'rubygems/rubygems'
      elsif path =~ %r{\Av\d+\.\d+/man/(bundle[_-]|gemfile)}
        path = "#{strip_version_from_url(path)}.ronn"
        path = "bundler/#{path}"
        'rubygems/rubygems'
      else
        path = File.join 'source', path
        'rubygems/bundler-site'
      end
    url = "https://github.com/#{repo}/blob/master/#{path}"
    
    link_to('Edit this document on GitHub', url) +
      ' if you caught an error or noticed something was missing.'
  end
  
  def path_exist?(page, version=nil)
    documentation_path(page, version)
  end
  
  def other_commands(primary_commands, version=nil)
    version ||= current_version
    
    current_man_pages = sitemap.resources.select{ |page| page.path.start_with?("#{version}/man/bundle-") }
    commands_from_man = current_man_pages.map{ |page| strip_man_path_to_page(page.path) } # ex: bundle-config.1
    comparable_commands_from_man = commands_from_man.map{ |page| normalize_man_page(page) } # ex: bundle_config
    
    current_other_pages = sitemap.resources.select{ |page| page.path.start_with?("#{version}/bundle_") }
    commands_from_others = current_other_pages.map{ |page| page.path[(version.length + 1)..-6] } # ex: bundle_console
    commands_from_others -= comparable_commands_from_man
    
    (commands_from_man + commands_from_others - primary_commands + ADDITIONAL_PAGES).sort do |x,y|
      normalize_man_page(x) <=> normalize_man_page(y)
    end
  end
  
  def current_visible_version
    current_page.url.scan(/v\d\.\d+/).first || current_version
  end
  
  def current_page_without_version
    strip_version_from_url(current_page.url)
  end
  
  private
  
  def strip_version_from_url(url)
    url.scan(/v\d\.\d+\/(.*).html/)&.first&.first || url
  end
  
  def normalize_man_page(page)
    return unless page
    
    page.gsub(/\.\d+$/, '').gsub('-', '_')
  end
  
  def strip_man_path_to_page(path)
    path.match(/man\/(.*)\.html$/)[1]
  end
  
  def check_single_page(path_part, version)
    path = "/#{version || current_version}#{path_part}"
    sitemap.find_resource_by_path(path) ? path : nil
  end
end
