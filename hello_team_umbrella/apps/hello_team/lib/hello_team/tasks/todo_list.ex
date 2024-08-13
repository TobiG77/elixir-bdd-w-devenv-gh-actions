defmodule HelloTeam.Tasks.TodoList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo_lists" do
    field :label, :string
    embeds_many :items, HelloTeam.Tasks.Item, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(todo_list, attrs) do
    todo_list
    |> cast(attrs, [:label])
    |> validate_required([:label])
    |> cast_embed(:items, with: &HelloTeam.Tasks.Item.changeset/2, required: true)
  end
end
