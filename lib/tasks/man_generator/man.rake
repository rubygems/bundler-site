desc "Pull in the man pages for the specified gem versions."
task man: :update_vendor do
  VERSIONS.each do |version|
    next if version == "v0.9"

    if version <= "v2.1"
      branch = (version[1..-1].split(".") + %w(stable)).join("-")
      vendor_folder = "vendor/bundler"
      man_folder = "man"
    else
      branch = Gem::Version.new(version[1..-1]).segments.map.with_index { |segment, i| i == 0 ? segment + 1 : segment }.join(".")
      vendor_folder = "vendor/rubygems/bundler"
      man_folder = "lib/bundler/man"
    end

    # v2.3 or later versions do not have `man` dir even after #922.
    mkdir_p "source/#{version}/man"

    Dir.chdir vendor_folder do
      sh "git reset --hard HEAD"
      sh "git checkout origin/#{branch}"
      sh "#{Gem.ruby} -S ronn -5 #{man_folder}/*.ronn"

      segments_up = vendor_folder.split(File::SEPARATOR).map { |_| ".." }.join(File::SEPARATOR)

      cp(FileList["#{man_folder}/*.html"], "#{segments_up}/source/#{version}/man")
      sh "git clean -fd"

      Rake::Task["man:strip_pages"].execute("#{segments_up}/source/#{version}/man")
    end
  end
end
