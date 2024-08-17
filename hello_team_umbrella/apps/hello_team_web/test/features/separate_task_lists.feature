Feature: Separate Task Lists

  Scenario: Each Task List has its own set of items
    Given a todo list "cleaning" with 5 items
    And a todo list "shopping" with 3 items
    Then todo list "shopping" should only show 3 items
    And todo list "cleaning" should only show 5 items


  # Scenario: Each Task List has its own set of sub tasks
  #   Given there are 2 Task lists
  #   And each task list has 3 sub tasks
  #   When I view the first task list
  #   Then I should only see the items from this task list

  # Scenario: Adding an item to a task list
  #   Given there is a task list
  #   And this task list has no sub tasks
  #   When I view the task list it should be empty
  #   And when I add an sub task to this task list
  #   Then I should see the new sub task
