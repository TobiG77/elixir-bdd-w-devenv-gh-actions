defmodule HelloTeamWeb.Features.SeparateTaskLists do
  # Options, other than file:, are passed directly to `ExUnit`
  use Cabbage.Feature, async: false, file: "separate_task_lists.feature"
  use HelloTeamWeb.ConnCase
  import Phoenix.LiveViewTest

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

  defgiven ~r/^a todo list "(?<task_label>[^"]+)" with (?<number_of_sub_tasks>\d+) items$/,
           %{task_label: task_label, number_of_sub_tasks: number_of_sub_tasks},
           %{tasks: existing_tasks} do
    sub_tasks =
      Enum.map(1..String.to_integer(number_of_sub_tasks), fn _ ->
        %{label: Faker.Company.buzzword(), description: Faker.Lorem.word()}
      end)

    {:ok, task} = Todos.create_task(%{label: task_label, sub_tasks: sub_tasks})

    assert task.label == task_label
    assert length(task.sub_tasks) == length(sub_tasks)

    %{tasks: [existing_tasks | task]}
  end

  @tag skip: "TODO, needs working data entry first"
  defthen ~r/^todo list "(?<task_label>[^"]+)" should only show (?<number_of_sub_tasks>\d+) items$/,
          %{number_of_sub_tasks: number_of_sub_tasks, task_label: task_label},
          %{conn: conn} do
    # TODO: this tests what is persisted in DB, not was is shown in UI
    # adjust to access liveview module
    matching_task = Enum.filter(Todos.list_tasks(), fn t -> t.label == task_label end)
    assert length(matching_task) == 1
    matching_task = Enum.at(matching_task, 0)

    task_url = "/tasks/" <> Integer.to_string(matching_task.id)
    {:ok, view, _html} = live(conn, task_url)

    assert length(matching_task.sub_tasks) == String.to_integer(number_of_sub_tasks)
  end
end
