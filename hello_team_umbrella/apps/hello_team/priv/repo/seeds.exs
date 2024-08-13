# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     HelloTeam.Repo.insert!(%HelloTeam.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias HelloTeam.Todos.Task
alias HelloTeam.Todos.SubTask

shopping_list =
  %Task{
    label: "shopping",
    sub_tasks: [
      %SubTask{label: "banana"},
      %SubTask{label: "carrot"}
    ]
  }
  |> HelloTeam.Repo.insert!()

chore_list =
  %Task{
    label: "house cleaning",
    sub_tasks: [
      %SubTask{label: "vacuum"},
      %SubTask{label: "rubbish"},
      %SubTask{label: "clean pool"}
    ]
  }
  |> HelloTeam.Repo.insert!()
