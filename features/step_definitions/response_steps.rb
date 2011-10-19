Then /^the response is a compressed gem index that contains exactly the following gems:$/ do |table|
  last_response.content_type.should eq "application/x-gzip"
  lambda { read_compressed_gem_index(last_body) }.should_not raise_error
  assert_exactly_these_gems_in_index(table)
end

Then /^the response is a compressed gemspec for the "([^"]*)" gem version (\d+\.\d+\.\d+)$/ do |name, version|
  # FIXME: WEBrick does not have rz => x-deflate mime type mapping
  # last_response.content_type.should eq "application/x-deflate"
  gemspec = nil
  lambda { gemspec = read_compressed_gemspec(last_body) }.should_not raise_error
  gemspec.name.should eq name
  gemspec.version.should eq Gem::Version.new(version)
end

Then /^the response is the "([^"]*)" gem version (\d+\.\d+\.\d+) package$/ do |name, version|
  gemspec = nil
  Gem::Package.open(StringIO.new(last_body)) { |ti| gemspec = ti.metadata }
  gemspec.name.should eq name
  gemspec.version.should eq Gem::Version.new(version)
end

Then /^the response status is (\d+)$/ do |status|
  last_response.status.should eq status.to_i
end
