Feature: Play levels
  In order to play ruby survivor
  As a player
  I want to advance through levels or retry them
  
  Background:
    Given no profile at "tmp"
  
  Scenario: Pass first level, fail second level
    Given a profile named "Joe" on "beginner"
    When I copy fixture "walking_player.rb" to "tmp/rubysurvivor/joe-beginner/player.rb"
    And I run rubysurvivor
    And I choose "Joe - beginner - level 1" for "profile"
    And I answer "y" to "next level"
    Then I should see "the updated README in the rubysurvivor/joe-beginner directory"
    When I run rubysurvivor
    And I choose "Joe - beginner - level 2" for "profile"
    And I answer "y" to "clues"
    Then I should see "survivor.feel.empty?"
  
  Scenario: Retry first level
    Given a profile named "Joe" on "beginner"
    When I copy fixture "walking_player.rb" to "tmp/rubysurvivor/joe-beginner/player.rb"
    And I run rubysurvivor
    And I choose "Joe - beginner - level 1" for "profile"
    And I answer "n" to "next level"
    Then I should see "current level"
    When I run rubysurvivor
    Then I should see "Joe - beginner - level 1"
  
  Scenario: Replay levels as epic when finishing last level with grades
    When I copy fixture "short-area" to "areas/short"
    Given a profile named "Bill" on "short"
    When I copy fixture "walking_player.rb" to "tmp/rubysurvivor/bill-short/player.rb"
    And I run rubysurvivor
    And I choose "Bill - short - level 1" for "profile"
    Then I answer "y" to "next level"
    And I should see "the updated README in the rubysurvivor/bill-short directory"
    When I run rubysurvivor
    And I choose "Bill - short - level 2" for "profile"
    Then I answer "y" to "epic"
    And I should see "epic mode"
    When I run rubysurvivor
    And I choose "Bill - short - first score 34 - epic score 0" for "profile"
    Then I should see "Level Grade: S"
    When I run rubysurvivor
    And I choose "Bill - short - first score 34 - epic score 34" for "profile"
    Then I should see "grade for this area"
    When I run rubysurvivor
    Then I should see "Bill - short - first score 34 - epic score 34"
  
  Scenario: Continue normal mode after epic mode when level added
    When I copy fixture "short-area" to "areas/short"
    Given a profile named "Bob" on "short"
    When I copy fixture "walking_player.rb" to "tmp/rubysurvivor/bob-short/player.rb"
    And I run rubysurvivor
    And I choose "Bob - short - level 1" for "profile"
    Then I answer "y" to "next level"
    And I should see "the updated README in the rubysurvivor/bob-short directory"
    When I run rubysurvivor
    And I choose "Bob - short - level 2" for "profile"
    Then I answer "y" to "epic"
    And I should see "epic mode"
    When I copy fixture "short-area/level_002.rb" to "areas/short/level_003.rb"
    And I run rubysurvivor
    And I choose "Bob - short - first score 34 - epic score 0" for "profile"
    And I should see "Another level"
    When I run rubysurvivor
    And I choose "Bob - short - level 3" for "profile"
    Then I answer "y" to "epic"
    And I should see "epic mode"
