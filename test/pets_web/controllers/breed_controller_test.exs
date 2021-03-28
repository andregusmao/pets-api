defmodule PetsWeb.BreedControllerTest do
  use PetsWeb.ConnCase

  alias Pets.Pet
  alias Pets.Pet.Breed

  @create_attrs %{
    kind: "some kind",
    name: "some name",
    origin: "some origin",
    size: "some size"
  }
  @update_attrs %{
    kind: "some updated kind",
    name: "some updated name",
    origin: "some updated origin",
    size: "some updated size"
  }
  @invalid_attrs %{kind: nil, name: nil, origin: nil, size: nil}

  def fixture(:breed) do
    {:ok, breed} = Pet.create_breed(@create_attrs)
    breed
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all breeds", %{conn: conn} do
      conn = get(conn, Routes.breed_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create breed" do
    test "renders breed when data is valid", %{conn: conn} do
      conn = post(conn, Routes.breed_path(conn, :create), breed: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.breed_path(conn, :show, id))

      assert %{
               "id" => id,
               "kind" => "some kind",
               "name" => "some name",
               "origin" => "some origin",
               "size" => "some size"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.breed_path(conn, :create), breed: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update breed" do
    setup [:create_breed]

    test "renders breed when data is valid", %{conn: conn, breed: %Breed{id: id} = breed} do
      conn = put(conn, Routes.breed_path(conn, :update, breed), breed: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.breed_path(conn, :show, id))

      assert %{
               "id" => id,
               "kind" => "some updated kind",
               "name" => "some updated name",
               "origin" => "some updated origin",
               "size" => "some updated size"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, breed: breed} do
      conn = put(conn, Routes.breed_path(conn, :update, breed), breed: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete breed" do
    setup [:create_breed]

    test "deletes chosen breed", %{conn: conn, breed: breed} do
      conn = delete(conn, Routes.breed_path(conn, :delete, breed))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.breed_path(conn, :show, breed))
      end
    end
  end

  defp create_breed(_) do
    breed = fixture(:breed)
    %{breed: breed}
  end
end
