defmodule HelloTeam.Todos.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :label, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:label, :description])
    |> validate_required([:label, :description])
  end
end
