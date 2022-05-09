defmodule PetClinic.PetClinicService.ExpertSpecialities do
  @moduledoc """
  Defines the schema of a expert specialities
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "expert_specialities" do
    # creo que tengo que agregar el foregin key
    belongs_to :pet_health_expert, PetClinic.PetClinicService.PetHealthExpert
    belongs_to :pet_type, PetClinic.PetClinicService.PetType

    timestamps()
  end
end
