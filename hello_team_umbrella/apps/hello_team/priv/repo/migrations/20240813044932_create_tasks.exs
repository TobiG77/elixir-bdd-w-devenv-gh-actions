defmodule HelloTeam.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :label, :string
      add :sub_tasks, {:array, :map}, default: []

      timestamps()
    end
  end
end
