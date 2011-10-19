module Matchers
  require 'rspec/expectations'

  RSpec::Matchers.define :have_same_members_as do
    match do
      (missing_from_expected.size == 0) && (missing_from_actual.size == 0)
    end
    
    failure_message_for_should do
      msg = "expected that #{actual} would have same members as #{expected}"      
      missing_from_expected_msg = "\n#{missing_from_expected.map { |m| " ? #{m}" }.join("\n")} were expected" unless missing_from_expected.empty?
      missing_from_actual_msg   = "\n#{missing_from_actual.map { |m| " X #{m}" }.join("\n")} were not expected" unless missing_from_actual.empty?
      diff = [missing_from_actual_msg, missing_from_expected_msg].compact      
      "#{msg} but #{diff.join(' and ')}"
    end

    def missing_from_expected
      actual - expected.first
    end

    def missing_from_actual
      expected.first - actual
    end
  end
end

World(Matchers)
