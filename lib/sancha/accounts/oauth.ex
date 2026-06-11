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
    |> prepare_changes(fn changeset ->
      slack_id = get_field(changeset, :slack_id)
      avatar_url = get_field(changeset, :avatar)

      if !is_nil(slack_id) and is_nil(avatar_url) do
        put_change(changeset, :avatar, "https://cachet.dunkirk.sh/users/#{slack_id}/r")
      else
        changeset
      end
    end)
  end
end
