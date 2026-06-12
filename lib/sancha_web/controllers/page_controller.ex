defmodule SanchaWeb.PageController do
  use SanchaWeb, :controller

  def home(conn, _params) do
    if get_session(conn, :user_id) do
      conn
      |> redirect(to: "/dash")
      |> halt()
    else
      render(conn, :home)
    end
  end

  def signin(conn, _params) do
    render(conn, :login)
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: ~p"/")
  end
end
