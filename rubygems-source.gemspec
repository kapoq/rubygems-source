# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubygems-source/version"

Gem::Specification.new do |s|
  s.name        = "rubygems-source"
  s.version     = Rubygems::Source::VERSION
  s.authors     = ["dave@kapoq.com"]
  s.email       = ["dave@kapoq.com"]
  s.homepage    = ""
  s.summary     = "A Rubygems remote source server"
  s.description = "A Rubygems remote source server that implements the core Rubygems web API (gem indicies, specs, push, and yank). Wins for local and private gem servers."

  s.add_dependency "sinatra"
  
  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "builder"
  s.add_development_dependency "gemcutter"
  if RUBY_PLATFORM =~ /linux/
    s.add_development_dependency "rb-inotify"
    s.add_development_dependency "libnotify"
  end
  
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
