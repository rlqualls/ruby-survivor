Feature: Manage Profiles
  In order to play ruby survivor
  As a player
  I want to create and choose profiles
  
  Background:
    Given no profile at "tmp"

  Scenario: New profile
    When I run rubysurvivor
    And I answer "y" to "create one?"
    And I choose "beginner" for "area"
    And I answer "Joe" to "name"
    Then I should see "generated"
    And I should find file at "tmp/rubysurvivor"
    When I run rubysurvivor
    Then I should see "Joe - beginner - level 1 - score 0"

  Scenario: Another new profile on same area
    Given a profile named "Joe" on "beginner"
    When I run rubysurvivor
    And I choose "New" for "profile"
    And I choose "beginner" for "area"
    And I answer "Bob" to "name"
    Then I should see "generated"
    When I run rubysurvivor
    Then I should see "Bob - beginner - level 1 - score 0"

  Scenario: Replace profile in same area with same name
    Given a profile named "Joe" on "beginner"
    When I run rubysurvivor
    And I choose "New" for "profile"
    And I choose "beginner" for "area"
    And I answer "Joe" to "name"
    And I answer "y" to "replace"
    Then I should see "generated"
    When I run rubysurvivor
    Then I should see "Joe - beginner - level 1 - score 0"
  
  Scenario: Auto select profile at given path
    Given a profile named "Joe" on "beginner"
    And current directory is "tmp/rubysurvivor/joe-beginner"
    When I copy fixture "walking_player.rb" to "tmp/rubysurvivor/joe-beginner/player.rb"
    And I run rubysurvivor
    And I answer "y" to "next level"
    Then I should see "the updated README in the rubysurvivor/joe-beginner directory"
