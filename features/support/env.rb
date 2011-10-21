require 'rubygems'
require 'bundler'

Bundler.setup
require 'rack/test'

require 'rubygems-source'

World(Rack::Test::Methods)
