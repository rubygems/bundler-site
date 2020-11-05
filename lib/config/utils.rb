def file_exist?(path)
  File.exist?("./source/#{path}") || File.exist?("./source/#{path}.haml") ||
    File.exist?("./source/localizable/#{path}.haml")
end

def man_page_exists?(man_page_name, version)
  File.exist?("./source/#{version}/#{man_page_name}.html") ||
    File.exist?("./source/#{version}/#{man_page_name}.html.haml")
end

def handle_man_page(file_path)
  file_path = file_path[0..-5]
  page_path = file_path.sub(/^\.\/source/, '')

  man_page_name_matched = file_path.match(/man\/(.*)\.html$/)
  return unless man_page_name_matched

  man_page_name = man_page_name_matched[1].gsub(/\.\d+$/, '').gsub('-', '_')
  man_page_name = 'gemfile_man' if man_page_name == 'gemfile'

  yield man_page_name, page_path if block_given?
end
