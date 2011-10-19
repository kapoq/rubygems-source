Feature: yank gem
  As a developer
  I want to yank gems from the server
  In order to defend other developers from sub-awesome code

  Scenario: yank existing gem version specifying a platform
    Given the following gems exist:
      | name    | version number | platform      |
      | terran  |          1.0.0 | ruby          |
      | terran  |          2.0.0 | ruby          |
      | terran  |          2.0.0 | x86-darwin-10 |
    When I make a DELETE request to "/api/v1/gems/yank" with gem_name "terran", version "2.0.0", and platform "ruby"
    Then the response status is 200
    And the full gem index contains exactly the following gems:
      | name    | version number | platform      |
      | terran  |          1.0.0 | ruby          |
      | terran  |          2.0.0 | x86-darwin-10 |

  Scenario: yank existing gem version without specifying a platform
    Given the following gems exist:
      | name    | version number | platform      |
      | terran  |          1.0.0 | ruby          |
      | terran  |          2.0.0 | ruby          |
      | terran  |          2.0.0 | x86-darwin-10 |
    When I make a DELETE request to "/api/v1/gems/yank" with gem_name "terran" and version "2.0.0"
    Then the response status is 200
    And the full gem index contains exactly the following gems:
      | name    | version number | platform      |
      | terran  |          1.0.0 | ruby          |
  
  Scenario: yank non-existent gem
    Given the following gems exist:
      | name    | version number | platform      |
      | terran  |          1.0.0 | ruby          |
      | terran  |          2.0.0 | x86-darwin-10 |
    When I make a DELETE request to "/api/v1/gems/yank" with gem_name "terran", version "2.0.0", and platform "ruby"
    Then the response status is 404
    And the full gem index contains exactly the following gems:
      | name    | version number | platform      |
      | terran  |          1.0.0 | ruby          |
      | terran  |          2.0.0 | x86-darwin-10 |
  
  
