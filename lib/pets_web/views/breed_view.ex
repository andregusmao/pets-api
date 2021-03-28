defmodule PetsWeb.BreedView do
  use PetsWeb, :view
  alias PetsWeb.BreedView

  def render("index.json", %{breeds: breeds}) do
    %{data: render_many(breeds, BreedView, "breed.json")}
  end

  def render("show.json", %{breed: breed}) do
    %{data: render_one(breed, BreedView, "breed.json")}
  end

  def render("breed.json", %{breed: breed}) do
    %{id: breed.id,
      kind: breed.kind,
      name: breed.name,
      size: breed.size,
      origin: breed.origin}
  end
end
