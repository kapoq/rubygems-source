Then /^I see help for the command$/ do
  assert_partial_output("Usage: gem rack [options]", all_output)
end

Then /^I see the server has started$/ do
  assert_partial_output("Server started", all_output)
end

Then /^I see the gem has been pushed successfully$/ do
  assert_partial_output("Successfully pushed gem", all_output)
end

