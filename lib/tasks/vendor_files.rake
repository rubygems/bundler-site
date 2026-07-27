directory "vendor"
directory "vendor/bundler" => ["vendor"] do
  system "git clone --depth 1 --no-single-branch https://github.com/rubygems/bundler.git vendor/bundler"
end

directory "vendor/rubygems" => ["vendor"] do
  system "git clone --depth 1 --no-single-branch https://github.com/ruby/rubygems.git vendor/rubygems"
end

task update_vendor: ["vendor/bundler", "vendor/rubygems"] do
  Dir.chdir("vendor/bundler") { sh "git fetch" }
  Dir.chdir("vendor/rubygems") { sh "git fetch" }
end
