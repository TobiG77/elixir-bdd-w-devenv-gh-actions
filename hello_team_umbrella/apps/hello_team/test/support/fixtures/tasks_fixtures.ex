defmodule HelloTeam.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelloTeam.Tasks` context.
  """

  @doc """
  Generate a todo_list.
  """
  def todo_list_fixture(attrs \\ %{}) do
    {:ok, todo_list} =
      attrs
      |> Enum.into(%{
        label: "some label"
      })
      |> HelloTeam.Tasks.create_todo_list()

    todo_list
  end
end
