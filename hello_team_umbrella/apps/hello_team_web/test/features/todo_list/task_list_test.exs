defmodule HelloTeamWeb.Features.TaskList do
  # Options, other than file:, are passed directly to `ExUnit`
  use Cabbage.Feature, async: false, file: "task_list.feature"
  use HelloTeamWeb.ConnCase

  alias HelloTeam.Todos

  # `setup_all/1` provides a callback for doing something before the entire suite runs
  # As below, `setup/1` provides means of doing something prior to each scenario
  setup do
    on_exit(fn ->
      IO.puts("Removing all task lists")
      task_lists = Todos.list_tasks()

      for task <- task_lists do
        IO.puts("Deleting task list: #{task.label}")
        Todos.delete_task(task)
      end
    end)

    %{tasks: []}
  end

  defgiven ~r/^a todo list "(?<task_label>[^"]+)" with (?<number_of_items>\d+) items$/,
           %{task_label: task_label, number_of_items: number_of_items},
           %{tasks: existing_tasks} do
    sub_tasks =
      Enum.map(1..String.to_integer(number_of_items), fn _ ->
        %{label: Faker.Company.buzzword(), description: Faker.Lorem.word()}
      end)

    {:ok, task} = Todos.create_task(%{label: task_label, sub_tasks: sub_tasks})

    assert task.label == task_label
    assert length(task.sub_tasks) == length(sub_tasks)

    %{tasks: [existing_tasks | task]}
  end
end
