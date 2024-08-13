defmodule HelloTeamWeb.TodoListLive.Index do
  use HelloTeamWeb, :live_view

  alias HelloTeam.Tasks
  alias HelloTeam.Tasks.TodoList

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :todo_lists, Tasks.list_todo_lists())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Todo list")
    |> assign(:todo_list, Tasks.get_todo_list!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Todo list")
    |> assign(:todo_list, %TodoList{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Todo lists")
    |> assign(:todo_list, nil)
  end

  @impl true
  def handle_info({HelloTeamWeb.TodoListLive.FormComponent, {:saved, todo_list}}, socket) do
    {:noreply, stream_insert(socket, :todo_lists, todo_list)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    todo_list = Tasks.get_todo_list!(id)
    {:ok, _} = Tasks.delete_todo_list(todo_list)

    {:noreply, stream_delete(socket, :todo_lists, todo_list)}
  end
end
