defmodule Sancha.Repo.Migrations.Uuid do
  use Ecto.Migration

  def change do
    create table(:uuids, primary_key: false) do
      add :uuid, :binary_id, primary_key: true
      add :claimed, :boolean, default: false, null: false
      add :claimed_by, :binary_id
    end

    create index(:uuids, [:uuid], where: "claimed = false")
    create index(:uuids, [:claimed_by])
  end
end
