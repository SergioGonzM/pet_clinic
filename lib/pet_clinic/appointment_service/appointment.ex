defmodule PetClinic.AppointmentService.Appointment do
  @moduledoc """
  Defines the schema of the appointmets service
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    belongs_to :pet, PetClinic.PetClinicService.Pet
    belongs_to :pet_health_expert, PetClinic.PetClinicService.PetHealthExpert
    field :datetime, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:datetime])
    |> validate_required([:datetime])
  end
end
