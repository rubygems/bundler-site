require 'nokogiri'

namespace :man do
  def extract_command_name(file_path)
    file_path.match(/man\/(.*)\.\d+\.html$/)[1].gsub('-', ' ')
  end

  def strip_html(command_name, content)
    # remove man navigation
    content.search('.man-navigation').remove
    content.search('ol.man-decor.man-head.man.head').remove
    content.search('ol.man-decor.man-foot.man.foot').remove

    # headers
    content.search('#SYNOPSIS').first.next_element.name = 'pre'
    content.search('#SYNOPSIS').remove
    content.search('h2, h3').each { |elem| elem.content = titleize(elem.content) }
    content.search('#NAME').first.content = command_name

    content
  end

  def titleize(header)
    header.split(' ').map(&:capitalize).join(' ')
  end

  task :strip_pages, :directory do |_, arg|
    puts
    puts '-' * 40
    puts "*** Parsing man pages in #{arg} ***"

    Dir.glob("#{arg}/**/*").select{ |f| !File.directory? f }.each do |file_path|
      puts "*** Processing #{file_path} ***"

      doc = File.open(file_path) { |f| Nokogiri::HTML(f) }
      rm_f file_path

      command_name = extract_command_name(file_path)
      content = strip_html(command_name, doc.at('body').children)

      File.write("#{file_path}.erb", content.to_html)
    end

    puts '-' * 40
    puts
  end
end
