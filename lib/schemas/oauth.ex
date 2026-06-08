defmodule Sancha.Oauth do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, Ecto.UUID, autogenerate: [version: 7]}
  schema "oauth" do
    field :name, :string
    field :email, :string
    field :slack_id, :string
    field :avatar, :string
    field :provider, :string
  end

  def changeset(oauth, attrs) do
    oauth
    |> cast(attrs, [:name, :email, :slack_id, :avatar, :provider])
    |> validate_required([:name, :email, :provider])
  end
end
