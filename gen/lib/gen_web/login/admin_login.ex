defmodule GenWeb.Login.AdminLogin do
  use GenWeb, :live_view

  alias Gen.Admin
  alias Gen.Repo
  alias Bcrypt

  def mount(_params, _session, socket) do
    case Repo.all(Admin) do
      [] ->
        {:ok,
         socket
         |> put_flash(:info, "No admin found. Please register.")
         |> push_navigate(to: "/register/admin")}

      [_ | _] ->
        changeset = Admin.changeset(%Admin{}, %{})
        {:ok, assign(socket, form: to_form(changeset))}
    end
  end

  @spec handle_event(<<_::40>>, map(), Phoenix.LiveView.Socket.t()) :: {:noreply, map()}
  def handle_event("login", %{"admin" => %{"email" => email, "password" => password}}, socket) do
    case Repo.get_by(Admin, email: email) do
      nil ->
        {:noreply,
         socket
         |> put_flash(:error, "Invalid email or password.")
         |> push_navigate(to: "/login/admin")}


      admin ->
        if Bcrypt.verify_pass(password, admin.hashed_password) do
          {:noreply,
           socket
           |> put_flash(:info, "Welcome back, #{admin.name}!")
           |> push_navigate(to: "/admin")}
        else
          {:noreply,
           socket
           |> put_flash(:error, "Invalid email or password.")}
        end
    end
  end
end
