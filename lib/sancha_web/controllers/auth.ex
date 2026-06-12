defmodule Sancha.AuthController do
  require Logger
  import Plug.Conn
  import Phoenix.Controller
  alias Sancha.Repo

  def on_success(conn, user) do
    attrs = Map.take(user, [:name, :email, :slack_id, :avatar, :provider])
    changeset = Sancha.Oauth.changeset(%Sancha.Oauth{}, attrs)

    user =
      Repo.insert!(changeset,
        conflict_target: :email,
        on_conflict: {:replace, [:provider, :avatar]},
        returning: true
      )

    conn
    |> configure_session(renew: true)
    |> put_session(:user_id, user.uuid)
    |> put_flash(:info, "Logged in as #{user.email}")
    |> redirect(to: "/dash")
  end

  def on_failure(conn, reason) do
    Logger.warning(reason)

    conn
    |> put_flash(:error, "Authentication Error")
    |> redirect(to: "/dash")
  end
end
