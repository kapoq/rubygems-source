Feature: get gem indices
  As an API user
  I want to be able to get gem indices
  So I know what gems are available to install 

  Background:
    Given the following gems exist:
      | name    | version number | platform |
      | terran  |          1.0.0 | ruby     |
      | terran  |          2.0.0 | ruby     |
      | protoss |          0.0.1 | ruby     |
      | protoss |      0.1.0.pre | ruby     |
      
  Scenario: fetch index of latest version of all gems
    When I make a GET request to "/latest_specs.4.8.gz"
    Then the response is a compressed gem index that contains exactly the following gems:
      | name    | version number | platform |
      | terran  |          2.0.0 | ruby     |
      | protoss |          0.0.1 | ruby     |
    
  Scenario: fetch index of all versions of all gems
    When I make a GET request to "/specs.4.8.gz"
    Then the response is a compressed gem index that contains exactly the following gems:
      | name    | version number | platform |
      | terran  |          1.0.0 | ruby     |
      | terran  |          2.0.0 | ruby     |
      | protoss |          0.0.1 | ruby     |

  Scenario: fetch index of all prerelease versions of all gems
    When I make a GET request to "/prerelease_specs.4.8.gz"
    Then the response is a compressed gem index that contains exactly the following gems:
      | name    | version number | platform |
      | protoss | 0.1.0.pre      | ruby     |
