defmodule GenWeb.AuthController do
  use GenWeb, :controller

  alias Gen.Admin
  alias Gen.Repo
  alias Bcrypt

  def login(conn, %{"admin" => %{"email" => email, "password" => password}}) do
    case Repo.get_by(Admin, email: email) do
      nil ->
        conn
        |> put_flash(:error, "Invalid email or password.")
        |> redirect(to: "/login/admin")

      admin ->
        if Bcrypt.verify_pass(password, admin.hashed_password) do
          conn
          |> put_session(:admin_id, admin.id)
          |> put_flash(:info, "Welcome back, #{admin.name}!")
          |> redirect(to: "/admin")
        else
          conn
          |> put_flash(:error, "Invalid email or password.")
          |> redirect(to: "/login/admin")
        end
    end
  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: "/login/admin")
  end
end
