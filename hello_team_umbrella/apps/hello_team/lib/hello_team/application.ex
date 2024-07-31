defmodule HelloTeam.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelloTeam.Repo,
      {DNSCluster, query: Application.get_env(:hello_team, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HelloTeam.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HelloTeam.Finch}
      # Start a worker by calling: HelloTeam.Worker.start_link(arg)
      # {HelloTeam.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: HelloTeam.Supervisor)
  end
end
