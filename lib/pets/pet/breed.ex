defmodule Pets.Pet.Breed do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "breeds" do
    field :kind, :string
    field :name, :string
    field :size, :string
    field :origin, :string

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(breed, attrs) do
    breed
    |> cast(attrs, [:kind, :name, :size, :origin])
    |> validate_required([:kind, :name, :size, :origin])
    |> unique_constraint(:name)
    |> validate_length(:kind, max: 1)
    |> validate_length(:size, max: 1)
  end
end
