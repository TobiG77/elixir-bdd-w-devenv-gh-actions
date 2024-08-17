defmodule HelloTeamWeb.Features.NewTaskList do
  # Options, other than file:, are passed directly to `ExUnit`
  use Cabbage.Feature, async: false, file: "new_task_list.feature"
  use HelloTeamWeb.ConnCase
  import Phoenix.LiveViewTest

  alias HelloTeam.Todos

  # `setup_all/1` provides a callback for doing something before the entire suite runs
  # As below, `setup/1` provides means of doing something prior to each scenario
  setup do
    on_exit(fn ->
      IO.puts("Removing all tasks")
      task_lists = Todos.list_tasks()

      for task <- task_lists do
        IO.puts("Deleting task: #{task.label}")
        Todos.delete_task(task)
      end
    end)
  end

  defgiven ~r/^we visit the URL "(?<url_path>[^"]+)"$/,
           %{url_path: url_path},
           %{conn: conn} = state do
    {:ok, view, _html} = live(conn, url_path)

    {:ok, Map.put(state, :view, view)}
  end

  defthen ~r/^the "(?<form_tag>[^"]+)" form is rendered$/,
          %{form_tag: form_tag},
          %{view: view} = state do
    assert has_element?(view, "#" <> form_tag)
    {:ok, Map.put(state, :form_tag, form_tag)}
  end

  defthen ~r/^we enter the task label "(?<task_label>[^"]+)"$/,
          %{task_label: task_label},
          %{view: view, form_tag: form_tag} = state do
    form =
      view
      |> form("#" <> form_tag, %{"task" => %{"label" => task_label}})
      |> render_change()

    assert form =~ task_label

    new_state =
      state
      |> Map.put(:task_label, task_label)
      |> Map.put(:form, form)

    {:ok, new_state}
  end

  defthen ~r/^we press the button "(?<button_label>[^"]+)"$/,
          %{button_label: button_label},
          %{view: view} = state do
    assert view
           |> element("#" <> button_label)
           |> render_click()

    {:ok, Map.put(state, :view, view)}
  end

  defthen ~r/^we enter the subtask label "(?<sub_task_label>[^"]+)"$/,
          %{sub_task_label: sub_task_label},
          %{form_tag: form_tag, view: view, task_label: task_label} = state do
    assert view
           |> form("#" <> form_tag, %{"task" => %{"label" => task_label}})
           |> render_change(%{"sub_task_label_0" => sub_task_label}) =~
             sub_task_label

    new_state =
      state
      |> Map.put(:sub_task_label, sub_task_label)
      |> Map.put(:view, view)

    {:ok, new_state}
  end

  defthen ~r/^we submit the form$/,
          _vars,
          %{
            form_tag: form_tag,
            view: view
          } = state do
    submitted_form =
      view
      |> element("#" <> form_tag)
      |> render_submit()

    {:ok, Map.put(state, :submitted_form, submitted_form)}
  end

  defthen ~r/^we expect the error message "(?<error_message>[^"]+)"$/,
          %{error_message: error_message},
          %{submitted_form: submitted_form} = _state do
    html_save_error_msg =
      error_message
      |> Phoenix.HTML.html_escape()
      |> Phoenix.HTML.safe_to_string()

    assert submitted_form =~ html_save_error_msg
  end

  defthen ~r/^we expect the task list to exist$/, _vars, %{task_label: task_label} = state do
    matching_tasks =
      HelloTeam.Todos.list_tasks()
      |> Enum.filter(fn t -> t.label == task_label end)

    assert length(matching_tasks) == 1
  end
end
