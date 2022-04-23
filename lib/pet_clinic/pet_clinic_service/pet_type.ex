defmodule PetClinic.PetClinicService.PetType do
    use Ecto.Schema
    import Ecto.Changeset
  
    schema "pet_types" do
      field :name, :string
 
      timestamps()
    end
end