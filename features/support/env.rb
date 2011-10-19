require 'rubygems'
require 'bundler'

Bundler.setup
require 'rack/test'

require 'rubygems-source'

World(Rack::Test::Methods)

def app
  Rubygems::Source::App.new
end
