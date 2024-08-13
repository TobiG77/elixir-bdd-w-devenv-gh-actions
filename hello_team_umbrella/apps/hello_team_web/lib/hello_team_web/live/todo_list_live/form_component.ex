defmodule HelloTeamWeb.TodoListLive.FormComponent do
  use HelloTeamWeb, :live_component

  alias HelloTeam.Tasks

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage todo_list records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="todo_list-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:label]} type="text" label="Label" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Todo list</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{todo_list: todo_list} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Tasks.change_todo_list(todo_list))
     end)}
  end

  @impl true
  def handle_event("validate", %{"todo_list" => todo_list_params}, socket) do
    changeset = Tasks.change_todo_list(socket.assigns.todo_list, todo_list_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"todo_list" => todo_list_params}, socket) do
    save_todo_list(socket, socket.assigns.action, todo_list_params)
  end

  defp save_todo_list(socket, :edit, todo_list_params) do
    case Tasks.update_todo_list(socket.assigns.todo_list, todo_list_params) do
      {:ok, todo_list} ->
        notify_parent({:saved, todo_list})

        {:noreply,
         socket
         |> put_flash(:info, "Todo list updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_todo_list(socket, :new, todo_list_params) do
    case Tasks.create_todo_list(todo_list_params) do
      {:ok, todo_list} ->
        notify_parent({:saved, todo_list})

        {:noreply,
         socket
         |> put_flash(:info, "Todo list created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
