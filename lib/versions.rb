# frozen_string_literal: true

VERSIONS = Dir.chdir("source") { Dir.glob("v*").sort_by{|x| Gem::Version.new(x[1..-1]) } }.freeze
