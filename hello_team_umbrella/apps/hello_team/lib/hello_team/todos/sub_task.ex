defmodule HelloTeam.Todos.SubTask do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :label, :string
  end

  def changeset(sub_task, attrs) do
    sub_task
    |> cast(attrs, [:label])
    |> validate_required([:label])
  end
end
