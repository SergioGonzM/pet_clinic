defmodule PetClinic.PetClinicService.PetHealthExpert do
  @moduledoc """
  Defines the Schema for a pet heatl expert
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "pethealthexperts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    # field :specialities, :string
    # quitar cuando haga la migracion
    many_to_many :specialities, PetClinic.PetClinicService.PetType,
      join_through: PetClinic.PetClinicService.ExpertSpecialities

    has_many :patients, PetClinic.PetClinicService.Pet, foreign_key: :preferred_expert_id

    has_many :appointments, PetClinic.AppointmentService.Appointment,
      foreign_key: :pet_health_expert_id

    has_one :schedule, PetClinic.AppointmentService.ExpertSchedule,
      foreign_key: :pet_health_expert_id

    timestamps()
  end

  @doc false
  def changeset(pet_health_expert, attrs) do
    pet_health_expert
    |> cast(attrs, [:name, :age, :email, :sex])
    |> validate_required([:name, :age, :email, :sex])
  end
end
