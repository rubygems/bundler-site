def file_exist?(path)
  File.exist?("./source/#{path}") || File.exist?("./source/#{path}.haml") ||
    File.exist?("./source/localizable/#{path}.haml")
end

def man_page_exists?(man_page_name, version)
  File.exist?("./source/#{version}/#{man_page_name}.html") ||
    File.exist?("./source/#{version}/#{man_page_name}.html.haml")
end