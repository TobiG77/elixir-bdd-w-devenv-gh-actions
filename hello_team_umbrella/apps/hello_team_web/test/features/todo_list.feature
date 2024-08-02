Feature: Todo List

  Scenario: Each Todo List has its own set of items
    Given there are 2 todo lists
    And each todo list has some items
    When I view the todo list
    Then I should only see the items from this todo list

  Scenario: Adding an item to a todo list
    Given there is a todo list
    And this todo list has no items
    When I view the todo list it should be empty
    And when I add an item to this todo list
    Then I should see this one item
