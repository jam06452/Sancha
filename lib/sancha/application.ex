defmodule Sancha.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SanchaWeb.Telemetry,
      Sancha.Repo,
      {DNSCluster, query: Application.get_env(:sancha, :dns_cluster_query) || :ignore},
      {Oban, Application.fetch_env!(:sancha, Oban)},
      {Phoenix.PubSub, name: Sancha.PubSub},
      # Start a worker by calling: Sancha.Worker.start_link(arg)
      # {Sancha.Worker, arg},
      # Start to serve requests, typically the last entry
      Sancha.Uuid.Counter,
      SanchaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sancha.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SanchaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
