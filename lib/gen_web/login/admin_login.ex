defmodule GenWeb.Login.AdminLogin do
  use GenWeb, :live_view

  alias Gen.Admin
  alias Bcrypt

  def mount(_params, _session, socket) do
    changeset = Admin.changeset(%Admin{}, %{})
    {:ok, assign(socket, form: to_form(changeset))}
  end
end
