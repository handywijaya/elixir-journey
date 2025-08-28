defmodule BookVaultWeb.Router do
  use BookVaultWeb, :router
  use Plug.ErrorHandler

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BookVaultWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BookVaultWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/thermostat", ThermostatLive
  end

  scope "/api", BookVaultWeb do
    pipe_through :api

    get "/hello", HelloController, :index

    post "/books", BookController, :create
    get "/books", BookController, :index
    put "/books/:id", BookController, :update
    delete "/books/:id", BookController, :delete
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    body = %{error: Phoenix.Controller.status_message_from_template("#{conn.status}.json")} |> Jason.encode!()
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(conn.status || 500, body)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:book_vault, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BookVaultWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
