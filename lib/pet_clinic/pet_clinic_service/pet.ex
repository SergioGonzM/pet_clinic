defmodule PetClinic.PetClinicService.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pets" do
    field :age, :integer
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    
    belongs_to :type, PetClinic.PetClinicService.PetType
    belongs_to :owner, PetClinic.PetClinicService.Owner
    belongs_to :preferred_expert, PetClinic.PetClinicService.PetHealthExpert

    timestamps()
  end

  @doc false
  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name, :age, :type, :sex])
    |> validate_required([:name, :age, :type, :sex])
    |> validate_inclusion(:age, 1..100)
  end
end

