defmodule BookVault.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BookVaultWeb.Telemetry,
      BookVault.Repo,
      {DNSCluster, query: Application.get_env(:book_vault, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BookVault.PubSub},
      # Start a worker by calling: BookVault.Worker.start_link(arg)
      # {BookVault.Worker, arg},
      # Start to serve requests, typically the last entry
      BookVaultWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BookVault.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BookVaultWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
