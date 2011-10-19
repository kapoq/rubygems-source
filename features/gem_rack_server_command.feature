Feature: `gem rack` command
  as a Rubygems publisher
  I want to start a gem server
  so developers can install and manage gems

  Scenario: start server
    When I run `gem rack`
    Then I see the server has started

  Scenario: see help
    When I run `gem help rack`
    Then I see help for the command
