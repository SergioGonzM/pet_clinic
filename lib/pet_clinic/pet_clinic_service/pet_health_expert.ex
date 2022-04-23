defmodule PetClinic.PetClinicService.PetHealthExpert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pethealthexperts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    field :specialities, :string

    has_many :patients, PetClinic.PetClinicService.Pet, foreign_key: :preferred_expert_id

    timestamps()
  end

  @doc false
  def changeset(pet_health_expert, attrs) do
    pet_health_expert
    |> cast(attrs, [:name, :age, :email, :specialities, :sex])
    |> validate_required([:name, :age, :email, :specialities, :sex])
  end
end

