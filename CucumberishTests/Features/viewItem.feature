Feature: Viewing items

  Scenario: Viewing item details
    Given I am on the master screen
    And an item is available
    When I tap the item
    Then the detail screen is shown