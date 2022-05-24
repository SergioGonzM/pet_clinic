defmodule PetClinic.PetClinicService.PetType do
  @moduledoc """
  Defines the catalog of a pet type (species)
  """
  use Ecto.Schema
  import Ecto.Changeset
  # import Ecto.Changeset

  schema "pet_types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
