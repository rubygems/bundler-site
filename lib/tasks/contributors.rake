namespace :contributors do
  task :update do
    def small_avatar(url)
      connector = url.include?("?") ? "&" : "?"
      [url, "s=40"].join(connector)
    end

    core_team = %w[indirect segiddins hsbt colby-swandale]
    credited_elsewhere = core_team + %w[homu bundlerbot]

    require "octokit"
    require "yaml"
    client = Octokit::Client.new(auto_paginate: true)
    contributors = client.contributors("bundler/bundler", false)
    contributors.reject!{|c| credited_elsewhere.include?(c[:login]) }
    contributors.map! do |c|
      {
        avatar_url: small_avatar(c[:avatar_url]),
        commits: c[:contributions],
        href: c[:html_url],
        name: c[:login]
      }
    end
    contributors.sort_by! {|c| [-c[:commits], c[:name].downcase] }

    File.write("data/contributors.yml", YAML.dump(contributors))
  end
end
