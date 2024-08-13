defmodule HelloTeam.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelloTeam.Todos` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        label: "some label"
      })
      |> HelloTeam.Todos.create_task()

    task
  end
end
