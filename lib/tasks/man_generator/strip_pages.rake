require 'nokogiri'

namespace :man do
  def strip_html(content)
    content.search('.man-navigation').remove
    content.search('ol.man-decor.man-head.man.head').remove
    content.search('ol.man-decor.man-foot.man.foot').remove
    content.search('#SYNOPSIS').first.next_element.name = 'pre'
    content
  end

  task :strip_pages, :directory do |_, arg|
    puts
    puts '-' * 40
    puts "*** Parsing man pages in #{arg} ***"

    Dir.glob("#{arg}/**/*").select{ |f| !File.directory? f }.each do |file_path|
      puts "*** Processing #{file_path} ***"

      doc = File.open(file_path) { |f| Nokogiri::HTML(f) }
      rm_f file_path

      content = strip_html(doc.at('body').children)

      File.write("#{file_path}.erb", content.to_html)
    end

    puts '-' * 40
    puts
  end
end
