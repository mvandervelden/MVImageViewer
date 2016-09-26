Feature: Adding images

  Scenario: Adding an image
    Given I am on the list screen
    When I tap the add button
    And I agree to give access to the gallery
    And I select the first image from the gallery
    Then I return to the list screen
    And the image is added to the list
