#!/usr/bin/env ruby
# frozen_string_literal: true

require 'colorize'
require 'pathname'
require 'time'

errors = []

def matches(pattern, message)
  pattern = /\b#{Regexp.union(pattern)}\b/ if pattern.is_a?(Array)
  matches = []
  files = Pathname.glob(File.expand_path("../source/**/*.{html,md,markdown,erb,haml}*", __dir__))

  files.each do |file|
    next unless file.file?
    relative_path = file.relative_path_from(Pathname('..').expand_path(__dir__))

    skippable_directories = %w[source/man source/localizable source/layouts]

    next if relative_path.to_s =~ Regexp.union(skippable_directories)
    next if relative_path.to_s =~ %r{\Asource/v([\d.]+)} && Gem::Version.new($1) <= Gem::Version.new("1.15")
    # this hackily skips blog posts touched before September 17th, 2017:
    next if File.mtime(relative_path.to_s) < Time.parse("2017-09-17")

    File.readlines(file).each_with_index do |line, index|
      next unless line =~ pattern

      matches << "`#{relative_path}:#{index.succ}` #{message}"
    end
  end
  matches
end

errors.concat matches(%w[he she her his], "Don't use gendered pronouns")
errors.concat matches(%w[actually really just only], "Don't use superflous language")

if errors.empty?
  puts 'Specs passed'.colorize(:green)
else
  abort "The docs need some attention:\n\t- #{errors.join("\n\t- ")}".colorize(:red)
end
