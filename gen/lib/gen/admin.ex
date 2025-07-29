defmodule Gen.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt

  schema "admins" do
    field :email, :string
    field :password, :string, virtual: true
    field :name, :string
    field :hashed_password, :string

    timestamps()
  end

  @doc false
  def changeset(admin, attrs) do
  admin
  |> cast(attrs, [:name, :email, :password])
  |> validate_required([:name, :email, :password])
  |> validate_length(:password, min: 6)
  |> validate_format(:email, ~r/@/)
  |> validate_length(:email, max: 160)
  |> validate_length(:name, min: 2)
  |> validate_length(:name, max: 100)
  |> unique_constraint(:email)
  |> hash_password()
end

defp hash_password(changeset) do
  case get_change(changeset, :password) do
    nil -> changeset
    "" -> changeset
    password when is_binary(password) ->
      put_change(changeset, :hashed_password, Bcrypt.hash_pwd_salt(password))
  end
end
end
