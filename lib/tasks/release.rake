desc "Release the current commit to gh-pages on rubygems/bundler-site"
task release: [:build, :update_site] do
  commit = `git rev-parse HEAD`.chomp
  BRANCH_FOR_PAGES = "gh-pages".freeze

  Dir.chdir "vendor/bundler.github.io" do
    sh "git checkout #{BRANCH_FOR_PAGES}"

    rm_rf FileList["*"]
    cp_r FileList["../../build/*"], "./"
    File.write("CNAME", "bundler.io")

    sh "git add -A ."
    sh "git commit -m 'rubygems/bundler-site@#{commit}'"

    Bundler.with_clean_env do
      puts <<-TWO_FACTOR_WARNING
====================================================================
Please note that if you have two-factor auth enabled for your Github
account, you will need to use a github access token instead of your
account password.
====================================================================
      TWO_FACTOR_WARNING
      sh "git push origin #{BRANCH_FOR_PAGES}"
    end
  end

  Bundler.with_clean_env do
    sh "git push origin #{BRANCH_FOR_PAGES}"
  end
end
