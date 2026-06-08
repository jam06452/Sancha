defmodule Sancha.Repo.Migrations.Oauth do
  use Ecto.Migration

  def change do
    create table(:oauth, primary_key: false) do
      add :uuid, :uuid, null: false
      add :name, :string
      add :email, :string
      add :slack_id, :string
      add :avatar, :string
      add :provider, :string
    end

    create unique_index(:oauth, [:email])
  end
end
