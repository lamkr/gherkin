Feature:  Subtracting numbers with a Calculator
  In order to not learn math
  As someone who is bad at math
  I want to be able to subtract numbers using a Calculator

  Scenario:  Subtract positive numbers
    Given I have a Calculator
    When I subtract 1 and 1
    And I subtract the result and 1
    And I subtract the result and 1
    Then the result should be -2
