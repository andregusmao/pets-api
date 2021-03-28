defmodule Pets.Repo.Migrations.CreateBreeds do
  use Ecto.Migration

  def change do
    create table(:breeds, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :kind, :string, null: false
      add :name, :string, null: false
      add :size, :string, null: false
      add :origin, :string, null: false

      timestamps()
    end

    create unique_index(:breeds, [:name])
  end
end
