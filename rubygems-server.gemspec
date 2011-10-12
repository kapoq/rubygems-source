# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubygems-server/version"

Gem::Specification.new do |s|
  s.name        = "rubygems-server"
  s.version     = Rubygems::Server::VERSION
  s.authors     = ["dave@kapoq.com"]
  s.email       = ["dave@kapoq.com"]
  s.homepage    = ""
  s.summary     = %q{An enhanced rubygems server}
  s.description = %q{Skinnable, customizable, Rubygems server that implements the Rubygems web API with push, yank, install. Wins for local and private gem servers.}

  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rake"
  if RUBY_PLATFORM =~ /linux/
    s.add_development_dependency "rb-inotify"
    s.add_development_dependency "libnotify"
  end
  
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
