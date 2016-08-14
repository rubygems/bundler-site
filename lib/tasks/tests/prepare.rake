require 'nokogiri'
require 'fileutils'

namespace :tests do
  FOLDERS_TO_SEARCH = %w(build/man/**/* build/*/man/**/*)
  HTML_EXTENSION_REGEX = /\.html\z/
  BUNDLE_REGEX = /(\Abundle |\A$ bundle )(.*)/

  def all_files_to_search
    FOLDERS_TO_SEARCH.map do |folder|
      Dir.glob(folder).reject { |fn| File.directory?(fn) || !(fn =~ HTML_EXTENSION_REGEX) }
    end.flatten
  end

  def generate_rspec(filename, code_elements)
    stripped_elements = code_elements.to_a.select { |element| element.text =~ BUNDLE_REGEX }
    return if stripped_elements.empty?
    puts "[TESTS GENERATOR] **** Processing #{filename} ****"

    file = ["require 'rspec'"]
    file << ''
    file << "describe '#{filename}' do"

    stripped_elements.each_with_index do |code, i|
      command = code.text.match(BUNDLE_REGEX)

      file << "it '##{i}' do"
      file << "  bundle! '#{command[2].chomp}'"
      file << 'end'
    end

    file << 'end'
    file.join("\n")
  end

  def save_rspec(filename, file_content)
    dirname = File.dirname("specs/#{filename}")
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)

    File.write("specs/#{filename}_spec.rb", file_content)
  end

  desc 'Generates Bundler tests to `spec` directory'
  task :prepare => :build do
    puts '[TESTS GENERATOR] Starting...'
    puts '[TESTS GENERATOR] Cleaning old tests'
    sh 'rm -Rf specs'

    all_files_to_search.each do |filename|
      doc = File.open(filename) { |f| Nokogiri::HTML(f) }
      code_elements = doc.search('pre code')
      next if code_elements.empty?

      file_content = generate_rspec(filename, code_elements)
      next unless file_content

      save_rspec(filename, file_content)
    end

    puts '[TESTS GENERATOR] Tests generation done! Running rspec...'
  end
end
