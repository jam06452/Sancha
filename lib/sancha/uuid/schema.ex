defmodule Sancha.Uuid do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "uuids" do
    field :claimed, :boolean, default: false
    field :claimed_by, :binary_id
  end
end
