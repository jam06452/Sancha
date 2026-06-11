defmodule Sancha.Accounts do
  alias Sancha.Repo
  alias Sancha.Oauth

  def get_user(uuid) do
    case Repo.get(Oauth, uuid) do
      nil ->
        {:error, :not_found}

      user ->
        {:ok, Map.take(user, [:name, :email, :slack_id, :avatar])}
    end
  end
end
