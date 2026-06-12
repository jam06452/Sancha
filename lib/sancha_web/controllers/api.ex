defmodule SanchaWeb.APIController do
  use SanchaWeb, :controller

  def uuid(conn, _params) do
    {:ok, uuid} = Sancha.Uuid.Repo.claim_uuid()
    json(conn, uuid)
  end
end
