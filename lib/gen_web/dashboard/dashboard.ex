defmodule GenWeb.Dashboard.Dashboard do
  use GenWeb, :live_view

  alias Gen.Admin
  alias Gen.Repo

    def mount(_params, _session, socket) do
      admins = Repo.all(Admin)
      {:ok, assign(socket, admins: admins)}
    end
  end
