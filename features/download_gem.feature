Feature: download gem
  As an API user
  I want to download gems
  So I can reuse awesome code

  Scenario: download gem
    Given the following gem exists:
      | name    | version number | platform |
      | terran  |          1.0.0 | ruby     |
    When I make a GET request to "/gems/terran-1.0.0.gem"
    Then the response is the "terran" gem version 1.0.0 package
