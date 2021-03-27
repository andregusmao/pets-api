defmodule Pets.PetTest do
  use Pets.DataCase

  alias Pets.Pet

  describe "breeds" do
    alias Pets.Pet.Breed

    @valid_attrs %{kind: "some kind", name: "some name", origin: "some origin", size: "some size"}
    @update_attrs %{kind: "some updated kind", name: "some updated name", origin: "some updated origin", size: "some updated size"}
    @invalid_attrs %{kind: nil, name: nil, origin: nil, size: nil}

    def breed_fixture(attrs \\ %{}) do
      {:ok, breed} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pet.create_breed()

      breed
    end

    test "list_breeds/0 returns all breeds" do
      breed = breed_fixture()
      assert Pet.list_breeds() == [breed]
    end

    test "get_breed!/1 returns the breed with given id" do
      breed = breed_fixture()
      assert Pet.get_breed!(breed.id) == breed
    end

    test "create_breed/1 with valid data creates a breed" do
      assert {:ok, %Breed{} = breed} = Pet.create_breed(@valid_attrs)
      assert breed.kind == "some kind"
      assert breed.name == "some name"
      assert breed.origin == "some origin"
      assert breed.size == "some size"
    end

    test "create_breed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pet.create_breed(@invalid_attrs)
    end

    test "update_breed/2 with valid data updates the breed" do
      breed = breed_fixture()
      assert {:ok, %Breed{} = breed} = Pet.update_breed(breed, @update_attrs)
      assert breed.kind == "some updated kind"
      assert breed.name == "some updated name"
      assert breed.origin == "some updated origin"
      assert breed.size == "some updated size"
    end

    test "update_breed/2 with invalid data returns error changeset" do
      breed = breed_fixture()
      assert {:error, %Ecto.Changeset{}} = Pet.update_breed(breed, @invalid_attrs)
      assert breed == Pet.get_breed!(breed.id)
    end

    test "delete_breed/1 deletes the breed" do
      breed = breed_fixture()
      assert {:ok, %Breed{}} = Pet.delete_breed(breed)
      assert_raise Ecto.NoResultsError, fn -> Pet.get_breed!(breed.id) end
    end

    test "change_breed/1 returns a breed changeset" do
      breed = breed_fixture()
      assert %Ecto.Changeset{} = Pet.change_breed(breed)
    end
  end
end
