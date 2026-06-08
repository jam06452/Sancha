defmodule MyApp.AuthController do
  import Plug.Conn
  import Phoenix.Controller

  def on_success(conn, user) do
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
