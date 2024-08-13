defmodule HelloTeamWeb.TaskLive.Index do
  use HelloTeamWeb, :live_view

  alias HelloTeam.Todos
  alias HelloTeam.Todos.Task
  alias HelloTeam.Todos.SubTask

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :tasks, Todos.list_tasks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Task")
    |> assign(:task, Todos.get_task!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task")
    |> assign(:task, %Task{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tasks")
    |> assign(:task, nil)
  end

  @impl true
  def handle_info({HelloTeamWeb.TaskLive.FormComponent, {:saved, task}}, socket) do
    {:noreply, stream_insert(socket, :tasks, task)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    task = Todos.get_task!(id)
    {:ok, _} = Todos.delete_task(task)

    {:noreply, stream_delete(socket, :tasks, task)}
  end

  def handle_event("add_sub_task", _params, socket) do
    task = socket.assigns.task
    new_sub_tasks = task.sub_tasks ++ [%SubTask{label: "new sub task"}]
    updated_task = %Task{task | sub_tasks: new_sub_tasks}
    {:noreply, assign(socket, :task, updated_task)}
  end

  def handle_event("remove_sub_task", %{"index" => index}, socket) do
    task = socket.assigns.task
    new_sub_tasks = List.delete_at(task.sub_tasks, String.to_integer(index))
    updated_task = %Task{task | sub_tasks: new_sub_tasks}
    {:noreply, assign(socket, :task, updated_task)}
  end
end
