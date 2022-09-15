require "pathname"

# Match
# ([get an invite here](contributing/GETTING_HELP.md))
# [get an invite here](contributing/GETTING_HELP.md)
# Dont Match
# [Heroku support](https://www.heroku.com/support)
# [Heroku support](http://www.heroku.com/support)
RELATIVE_LINK_REGEX = %r{
  \[(?<title>.*)\]            # Match title
  \((?<link>[^(http)].*?)\)   # Match all non-http links
}x

def new_link(file, link)
  if link.end_with?("CODE_OF_CONDUCT.md")
    "conduct" # Special case we manually write
  elsif link.start_with?("mailto:") || link.start_with?("http")
    link
  else
    directory = Pathname.new(File.dirname(file))               # The directory : doc/contributing
    link_path = Pathname.new(link)                             # The path of the link : ../TROUBLESHOOTING.md
    new_link = File.expand_path(link_path, directory)          # The full local path : /path/to/site/doc/TROUBLESHOOTING.md
    new_link = new_link.gsub(Dir.pwd, "")                      # Remove the local part : /doc/TROUBLESHOOTING.md
    new_link.gsub!(/.md$/, ".html")                            # Remove .md
    new_link
  end
end

def write_file(file, to)
  content = File.read(file)
  content.gsub!(RELATIVE_LINK_REGEX) do |match_data|
    new_link = new_link(file.downcase, Regexp.last_match[:link].downcase)
    "[#{Regexp.last_match[:title]}](#{new_link})"
  end

  FileUtils.mkpath(File.dirname(to))
  File.write(to, content)
end

directory "vendor"
directory "vendor/bundler" => ["vendor"] do
  system "git clone --depth 1 --no-single-branch https://github.com/rubygems/bundler.git vendor/bundler"
end

directory "vendor/rubygems" => ["vendor"] do
  system "git clone --depth 1 --no-single-branch https://github.com/rubygems/rubygems.git vendor/rubygems"
end

task update_vendor: ["vendor/bundler", "vendor/rubygems"] do
  Dir.chdir("vendor/bundler") { sh "git fetch" }
  Dir.chdir("vendor/rubygems") { sh "git fetch" }
end

desc "Pulls in pages maintained in the bundler repo."
task repo_pages: :update_vendor do
  Dir.chdir "vendor/rubygems/bundler" do
    sh "git reset --hard HEAD"
    sh "git checkout origin/master"

    source_dir = File.expand_path("../source/", File.dirname(__dir__))
    Dir["doc/**/*.md"].each do |file|
      file_name = file[0..-4] # Removes .md suffix
      to = File.expand_path("./#{file_name}.html.md", source_dir).downcase
      write_file(file, to)
    end

    write_file("../CODE_OF_CONDUCT.md", File.expand_path("./conduct.html.md", source_dir))
  end
end
