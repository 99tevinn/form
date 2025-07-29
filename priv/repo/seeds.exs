# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Gen.Repo.insert!(%Gen.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Mix.Task.run("app.start")

alias Gen.Repo
alias Gen.Admin

admin = [
%{name: "Super Admin", email: "admin@example.com", role: "super", password: "securepassword123"},
%{name: "Tevin", email: "tevin@example.com", role: "admin", password: "anothersecurepass"}
]
for a <- admin do
  case Repo.get_by(Admin, email: a.email) do
    nil ->
      %Admin{}
      |> Admin.changeset(a)
      |> Repo.insert!()
      IO.puts("Admin with email #{a.email} created successfully.")

    _ ->
      IO.puts("Admin with email #{a.email} already exists, skipping.")
  end
end
