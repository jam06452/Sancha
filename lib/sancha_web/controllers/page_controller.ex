defmodule SanchaWeb.PageController do
  use SanchaWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
