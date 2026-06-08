defmodule Sancha.AuthController do
  import Plug.Conn
  import Phoenix.Controller
  alias Sancha.Repo

  def on_success(conn, user) do
    attrs = Map.take(user, [:name, :email, :slack_id, :avatar, :provider])
    changeset = Sancha.Oauth.changeset(%Sancha.Oauth{}, attrs)

    Repo.insert(changeset,
      conflict_target: :email,
      on_conflict: {:replace, [:provider, :avatar]},
      returning: true
    )
    
    IO.inspect(attrs)

    conn
    |> put_flash(:info, "Logged in as #{user.email}")
    |> put_resp_header("location", "/")
    |> send_resp(302, "Redirecting...")
    |> halt()
  end

  def on_failure(conn, reason) do
    IO.inspect(reason, label: "AUTH FAILURE")

    conn
    |> put_flash(:error, "Authentication Error")
    |> put_resp_header("location", "/")
    |> send_resp(302, "Redirecting...")
    |> halt()
  end
end
