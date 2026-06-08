defmodule Sancha.Repo do
  use Ecto.Repo,
    otp_app: :sancha,
    adapter: Ecto.Adapters.Postgres
end
