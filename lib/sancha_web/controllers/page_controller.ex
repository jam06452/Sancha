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
end
