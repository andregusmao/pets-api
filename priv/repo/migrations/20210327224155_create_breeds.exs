defmodule Pets.Repo.Migrations.CreateBreeds do
  use Ecto.Migration

  def change do
    create table(:breeds, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :kind, :string
      add :name, :string
      add :size, :string
      add :origin, :string

      timestamps()
    end

    create unique_index(:breeds, [:name])
  end
end
