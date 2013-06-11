Feature: Manage areas
  In order extend ruby survivor
  As a developer
  I want to manage areas
  
  Background:
    Given no profile at "tmp"
  
  Scenario: Add an area
    When I copy fixture "short-area" to "areas/short"
    And I run rubysurvivor
    And I answer "y" to "create one?"
    Then I should see "short"
  
