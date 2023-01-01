# frozen_string_literal: true

VERSIONS = Dir.chdir("source") { Dir.glob("v*").sort_by{ Gem::Version.new(_1[1..-1]) } }.freeze
