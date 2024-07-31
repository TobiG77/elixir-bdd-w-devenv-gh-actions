defmodule HelloTeam.Repo do
  use Ecto.Repo,
    otp_app: :hello_team,
    adapter: Ecto.Adapters.Postgres
end
