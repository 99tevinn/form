defmodule Gen.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :role, :string, null: false
      add :hashed_password, :string, null: false
      timestamps()
    end
  end
end
