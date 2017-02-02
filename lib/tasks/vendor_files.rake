directory "vendor"
directory "vendor/bundler" => ["vendor"] do
  system "git clone https://github.com/bundler/bundler.git vendor/bundler"
end

task :update_vendor => ["vendor/bundler"] do
  Dir.chdir("vendor/bundler") { sh "git fetch" }
end

desc "Pulls in pages maintained in the bundler repo."
task :repo_pages => [:update_vendor] do
  Dir.chdir "vendor/bundler" do
    sh "git reset --hard HEAD"
    sh "git checkout origin/master"
    cp "doc/contributing/ISSUES.md", "../../source/issues.html.md"
    cp "CODE_OF_CONDUCT.md", "../../source/conduct.html.md"
  end
end

directory "vendor/bundler.github.io" => ["vendor"] do
  system "git clone https://github.com/bundler/bundler.github.io vendor/bundler.github.io"
end

task :update_site => ["vendor/bundler.github.io"] do
  Dir.chdir "vendor/bundler.github.io" do
    sh "git checkout master"
    sh "git reset --hard HEAD"
    sh "git pull origin master"
  end
end
