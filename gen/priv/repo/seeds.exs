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

unless Repo.get_by(Admin, email: "admin@example.com") do
  admin_attrs = %{
    name: "Super Admin",
    email: "admin@example.com",
    password: "securepassword123"
  }

  changeset = Admin.changeset(%Admin{}, admin_attrs)
  Repo.insert!(changeset)

  IO.puts("✅ Seeded initial admin.")
else
  IO.puts("ℹ️ Admin already exists. Skipping seed.")
end
