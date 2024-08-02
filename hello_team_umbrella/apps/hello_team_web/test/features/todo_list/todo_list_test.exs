defmodule HelloTeamWeb.Features.TodoList do
  # Options, other than file:, are passed directly to `ExUnit`
  use Cabbage.Feature, async: false, file: "todo_list.feature"
  use HelloTeamWeb.ConnCase

  alias HelloTeam.Todos

  # `setup_all/1` provides a callback for doing something before the entire suite runs
  # As below, `setup/1` provides means of doing something prior to each scenario
  setup do
    on_exit(fn ->
      IO.puts("Removing items")
      items = Todos.list_items()
      for item <- items, do: Todos.delete_item(item)
    end)

    items =
      Enum.map(1..3, fn _ ->
        label = Faker.Person.name()
        description = Faker.Lorem.words()

        {:ok, item} =
          Todos.create_item(%{label: label, description: description})
        item
      end)

    initial_state = %{todos: items}
    IO.inspect(%{initial_state: initial_state})
    initial_state
  end

end
