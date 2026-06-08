defmodule Oauth do
  use Ecto.Schema

  @primary_key false
  schema "oauth" do
    field :uuid, Ecto.UUID, autogenerate: [version: 7]
    field :name, :string
    field :email, :string
    field :slack_id, :string
    field :avatar, :string
    field :provider, :string
  end
end
