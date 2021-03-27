defmodule Pets.Pet.Breed do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "breeds" do
    field :kind, :char
    field :name, :string
    field :size, :char
    field :origin, :string

    timestamps()
  end

  @doc false
  def changeset(breed, attrs) do
    breed
    |> cast(attrs, [:kind, :name, :size, :origin])
    |> validate_required([:kind, :name, :size, :origin])
    |> unique_constraint(:name)
    |>
  end
end
