defmodule HelloTeam.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelloTeam.Todos` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        description: "some description",
        label: "some label"
      })
      |> HelloTeam.Todos.create_item()

    item
  end
end
