  defmodule GenWeb.Auth.AdminAuth do
    import Phoenix.LiveView
    import Phoenix.Component

    alias Gen.Admin
    alias Gen.Repo

    @session_timeout 30 * 60 * 1000

    def on_mount(:default, _params, session, socket) do

      IO.inspect(session, label: "Session in on_mount")
      now = DateTime.utc_now()

      case session["admin_id"] do
        nil ->
          {:halt, redirect(socket, to: "/login/admin")}

        admin_id ->
          case Repo.get(Admin, admin_id) do
            nil ->
              {:halt,
              socket
              |> put_flash(:error, "Admin not found or session expired.")
              |> redirect( to: "/login/admin")}

            admin ->
              case session["login_time"] do
                nil ->
                  {:halt,
                  socket
                  |> put_flash(:error, "Session expired. Please log in again.")
                  |> redirect(to: "/login/admin")}
                login_time_str ->
                  case DateTime.from_iso8601(login_time_str) do
                    {:ok, login_time, _} ->
                      if DateTime.diff(now, login_time, :millisecond) > @session_timeout do
                        {:halt,
                        socket
                        |> put_flash(:error, "Session expired. Please log in again.")
                        |> redirect(to: "/login/admin")}
                      else
                        {:cont, assign(socket, current_admin: admin)}
                      end

                    _ ->
                      {:halt,
                      socket
                      |> put_flash(:error, "Invalid session data. Please log in again.")
                      |> redirect(to: "/login/admin")}
              end
          end
        end
      end
    end
  end
