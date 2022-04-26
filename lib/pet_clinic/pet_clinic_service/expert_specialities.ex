defmodule PetClinic.PetClinicService.ExpertSpecialities do
    use Ecto.Schema
    import Ecto.Changeset
  
    schema "expert_specialities" do
      has_many :pet_health_expert, PetClinic.PetClinicService.PetHealthExpert, foreign_key: :preferred_expert_id

      has_many :pet_type, PetClinic.PetClinicService.PetType
  
      timestamps()
    end
end
  
  