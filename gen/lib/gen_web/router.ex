defmodule GenWeb.Router do
  use GenWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {GenWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GenWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/register/admin", Register.Admin, :index
    live "/login/admin", Login.AdminLogin, :index
    post "/login", AuthController, :login
    get "/logout", AuthController, :logout
    live "/admin", Dashboard.Dashboard, :index
  end

  # Uncomment and customize if you need an API scope
  # scope "/api", GenWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:gen, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GenWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
