defmodule GenWeb.Dashboard.Dashboard do
  use GenWeb, :live_view

  alias Gen.Admin
  alias Gen.Repo

  def mount(_params, session, socket) do
    admin_id = session["admin_id"]

    case Repo.get(Admin, admin_id) do
      nil ->
        {:ok,
        socket
        |> put_flash(:error, "Please log in.")
        |> redirect(to: "/login/admin")}

      _admin ->
        admins = Repo.all(Admin)
        {:ok, assign(socket, :admins, admins)}
    end
  end
end
