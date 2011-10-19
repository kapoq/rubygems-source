Given /^an original version of a gem exists on the server$/ do
  TmpDirHelper.in_gem_dir do    
    build_gem("mygem", "1.0.0", "original version", "ruby")
  end
  clear_gem_specs_and_update_gem_indices
end

Given /^I have a new gem package for the gem with same version$/ do
  TmpDirHelper.in_local_dir do
    @package_name = build_gem("mygem", "1.0.0", "new version", "ruby")
  end
end

Given /^the following gem[s]? exist[s]?:$/ do |table|
  TmpDirHelper.in_gem_dir do
    table.hashes.each do |g|
      build_gem(g["name"], g["version number"], g.fetch("summary", "summary"), g["platform"])
    end
  end
  clear_gem_specs_and_update_gem_indices
end

Given /^a gem package for the gem "([^"]*)" version "([^"]*)"$/ do |name, version|
  TmpDirHelper.in_local_dir do
    @package_name = build_gem(name, version)
  end
end

Then /^the full gem index contains exactly the following gems:$/ do |table|
  get_full_index
  assert_exactly_these_gems_in_index(table)                                
end

Then /^the gem "([^"]*)" version "([^"]*)" is available to install from the server$/ do |name, version|
  assert_available_for_install(@package_name)
end

Then /^the orginal gem is still available to install from the server$/ do
  get_gemspec(@package_name)
  spec = read_compressed_gemspec(last_body)
  spec.summary.should eq "original version"
end
