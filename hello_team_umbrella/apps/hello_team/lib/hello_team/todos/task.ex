defmodule HelloTeam.Todos.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :label, :string
    embeds_many :sub_tasks, HelloTeam.Todos.SubTask, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:label])
    |> validate_required([:label])
  end
end
