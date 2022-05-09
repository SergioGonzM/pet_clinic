defmodule PetClinicWeb.PageController do
  use PetClinicWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def bar(conn, _params) do
    render(conn, "other_index.html")
  end

  # def pets/by_type/:type(conn, _params) do
  #  render(conn, "index.html")
  # end
end
