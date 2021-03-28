defmodule PetsWeb.BreedController do
  use PetsWeb, :controller

  alias Pets.Pet
  alias Pets.Pet.Breed

  action_fallback PetsWeb.FallbackController

  def index(conn, _params) do
    breeds = Pet.list_breeds()
    render(conn, "index.json", breeds: breeds)
  end

  def create(conn, %{"breed" => breed_params}) do
    with {:ok, %Breed{} = breed} <- Pet.create_breed(breed_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.breed_path(conn, :show, breed))
      |> render("show.json", breed: breed)
    end
  end

  def show(conn, %{"id" => id}) do
    breed = Pet.get_breed!(id)
    render(conn, "show.json", breed: breed)
  end

  def update(conn, %{"id" => id, "breed" => breed_params}) do
    breed = Pet.get_breed!(id)

    with {:ok, %Breed{} = breed} <- Pet.update_breed(breed, breed_params) do
      render(conn, "show.json", breed: breed)
    end
  end

  def delete(conn, %{"id" => id}) do
    breed = Pet.get_breed!(id)

    with {:ok, %Breed{}} <- Pet.delete_breed(breed) do
      send_resp(conn, :no_content, "")
    end
  end
end
