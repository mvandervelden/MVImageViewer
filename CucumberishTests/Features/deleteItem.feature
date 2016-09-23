Feature: Deleting items

Scenario: Deleting an item
Given I am on the master screen
And an item is available
When I swipe left on the item
And I tap the delete button
Then the item is deleted
