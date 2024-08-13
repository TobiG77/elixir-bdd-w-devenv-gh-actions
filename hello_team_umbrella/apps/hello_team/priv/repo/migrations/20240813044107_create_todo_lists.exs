defmodule HelloTeam.Repo.Migrations.CreateTodoLists do
  use Ecto.Migration

  def change do
    create table(:todo_lists) do
      add :label, :string
      add :items, {:array, :map}, default: []
      timestamps()
    end
  end
end
