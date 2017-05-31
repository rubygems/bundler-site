desc "Pull in the man pages for the specified gem versions."
task :man => [:update_vendor] do
  VERSIONS.each do |version|
    next if version == "v0.9"
    branch = (version[1..-1].split('.') + %w(stable)).join('-')

    rm_rf "source/#{version}/man"
    mkdir_p "source/#{version}/man"

    Dir.chdir "vendor/bundler" do
      sh "git reset --hard HEAD"
      sh "git checkout origin/#{branch}"
      sh "#{Gem.ruby} -S bundle exec ronn -5 man/*.ronn"
      cp(FileList["man/*.html"], "../../source/#{version}/man")
      sh "git clean -fd"

      Rake::Task["man:strip_pages"].execute("../../source/#{version}/man")
    end
  end

  # Make man pages for the latest version available at the top level, too.
  rm_rf "source/man"
  cp_r "source/#{VERSIONS.last}/man", "source"
end
