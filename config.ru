require 'rubygems'
require 'bundler/setup'
require 'staticmatic'

staticmatic = StaticMatic::Base.new('.')
use Rack::ShowExceptions
run StaticMatic::Server.new(staticmatic)
