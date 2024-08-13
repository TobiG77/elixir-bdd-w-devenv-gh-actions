defmodule HelloTeam.Tasks.Item do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name, :string
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
