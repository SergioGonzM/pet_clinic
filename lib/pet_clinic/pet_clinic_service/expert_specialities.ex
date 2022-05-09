defmodule PetClinic.PetClinicService.ExpertSpecialities do
  @moduledoc """
  Defines the schema of a expert specialities
  """
    use Ecto.Schema
    import Ecto.Changeset
  
    schema "expert_specialities" do
      belongs_to :pet_health_expert, PetClinic.PetClinicService.PetHealthExpert #creo que tengo que agregar el foregin key
      belongs_to :pet_type, PetClinic.PetClinicService.PetType
  
      timestamps()
    end
end
  
  