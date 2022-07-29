namespace :ci do
  def commit_author_email
    ENV["COMMIT_AUTHOR_EMAIL"]
  end

  task deploy: [:build, "vendor/ssh_bundler.github.io"] do
    commit = `git rev-parse HEAD`.chomp

    Dir.chdir "vendor/ssh_bundler.github.io" do
      rm_rf FileList["*"]
      cp_r FileList["../../build/*"], "./"
      File.write("CNAME", "bundler.io")

      # Copy gitconfig prepared by actions/checkout Action from .git/config
      # to get configuration for `git push`
      cp "../../.git/config", ".git/config"

      sh "git add -A ."

      sh "git config user.name 'GitHub Actions'"
      sh "git config user.email '#{commit_author_email}'"

      sh "git commit -m 'rubygems/bundler-site@#{commit}'"
      sh "git push origin #{BRANCH_FOR_PAGES}"
    end
  end
end
