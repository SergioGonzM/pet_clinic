defmodule PetClinic.Repo.Migrations.CreatePetTypesTable do
  use Ecto.Migration
  import Ecto.Query
  alias PetClinic.Repo
  alias PetClinic.PetClinicService.Pet
  alias PetClinic.PetClinicService.PetType

  def change do

    pets = from(p in "pets", select: %{type: p.type, id: p.id}) 
      |> Repo.all() 
      |> Enum.map(fn pet -> %{pet | type: pet.type 
      |> String.downcase()} 
    end)
    types = Repo.all(from p in Pet, select: [p.type], distinct: true) |> List.flatten()

    create table("pet_types") do
      add :name, :string
      timestamps()
    end
    
    flush()

    Enum.map(pet_types, fn t -> Repo.insert(PetType{name: t})end)

    alter table("pets") do
      remove :type
      add :type_id, references("pet_types")
    end

    flush()

    Enum.each(pets, fn pet ->
      %PetType{id: pet_type_id} = Repo.get_by(PetType, name: pet.type)
      update = "UPDATE pets SET type_id = $1 WHERE id = $2"
      Repo.query!(update, [pet.type_id, pet.id])
    end)

  end
end
