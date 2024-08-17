Feature: New Task List

  Scenario: Refuse task list without label
    Given we visit the URL "/tasks/new"
    Then the "task-form" form is rendered
    And we submit the form
    Then we expect the error message "can't be blank"

  Scenario: Create an empty task list
    Given we visit the URL "/tasks/new"
    Then the "task-form" form is rendered
    And we enter the task label "our new example task"
    And we submit the form 
    Then we expect the task list to exist

  Scenario: Creating a new task list
    Given we visit the URL "/tasks/new"
    Then the "task-form" form is rendered
    And we enter the task label "our new example task"
    Then we press the button "add-sub-task"
    And we enter the subtask label "our new example subtask"
  #   Then we submit the form 