def file_exist?(path)
  File.exist?("./source/#{path}") || File.exist?("./source/#{path}.haml") ||
    File.exist?("./source/localizable/#{path}.haml")
end