Feature: get gem spec
  As an API user
  I want to get a gem's spec
  So I can decide whether to use it

  Scenario: get gem spec
    Given the following gem exists:
      | name    | version number | platform |
      | terran  |          1.0.0 | ruby     |
    When I make a GET request to "/quick/Marshal.4.8/terran-1.0.0.gemspec.rz"
    Then the response is a compressed gemspec for the "terran" gem version 1.0.0
