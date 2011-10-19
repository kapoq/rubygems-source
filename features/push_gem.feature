Feature: push gem
  In order to share code
  As a developer
  I want to upload a gem to the gem server

  Scenario: push new gem
    Given a gem package for the gem "mygem" version "0.0.1"
    When I POST the gem package to "/api/v1/gems"
    Then the response status is 200
    And the gem "mygem" version "0.0.1" is available to install from the server
  
  Scenario: push new version of existing gem
    Given the following gem exists:
      | name  | version number | platform |
      | mygem |          1.0.0 | ruby     |
    And a gem package for the gem "mygem" version "1.0.1"
    When I POST the gem package to "/api/v1/gems"
    Then the response status is 200
    And the gem "mygem" version "1.0.1" is available to install from the server
    And the gem "mygem" version "1.0.0" is available to install from the server

  Scenario: push existing version of existing gem
    Given an original version of a gem exists on the server
    And I have a new gem package for the gem with same version
    When I POST the gem package to "/api/v1/gems"
    Then the response status is 409
    And the orginal gem is still available to install from the server

  Scenario: push something that is not a valid gem
    When I POST a file that is not a valid gem package to "/api/v1/gems"
    Then the response status is 403

