defmodule GenWeb.Register.Admin do
  use GenWeb, :live_view

  alias Gen.Admin
  alias Gen.Repo

  def mount(_params, _session, socket) do
    changeset = Admin.changeset(%Admin{}, %{})
    {:ok, assign(socket, form: to_form(changeset))}
  end

  def handle_event("validate", %{"admin" => params}, socket) do
    changeset =
      %Admin{}
      |> Admin.changeset(params)
      |> Map.put(:action, :validate)
    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("submit", %{"admin" => admin_params}, socket) do
    changeset = Admin.changeset(%Admin{}, admin_params)
    case Repo.insert(changeset) do
      {:ok, _admin} ->
        {:noreply,
        socket
        |> put_flash(:info, "Admin created successfully.")
        |> redirect(to: "/login/admin")}

      {:error, changeset} ->
        {:noreply,
        socket
        |> put_flash(:error, "Failed to create admin.")
        |> assign(form: to_form(changeset))}
    end
  end
end
