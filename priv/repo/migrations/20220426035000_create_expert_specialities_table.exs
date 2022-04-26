defmodule PetClinic.Repo.Migrations.CreateExpertSpecialitiesTable do
  use Ecto.Migration
  import Ecto.Query

  def change do
    experts = Repo.all(from e in PetHealthExpert, select: %{id: e.id, specialities: e.specialities}) 
    |> Enum.map(fn e -> %{e | specialities: e.specialities 
                            |> String.split([" ", ","], trim: true)} end) 

    create table "expert_specialities" do
      add :health_expert_id, references("pethealthexperts")
      add :pet_type_id, references("pet_types")
      timestamps()
    end

    flush()

    #falta hacer el insert y borrar la columna en el pethealthexpert
    experts |> Enum.each(fn e ->
      Enum.each(e.specialities, fn spec ->
        spec_id = from(p in "pet_types", where: p.name == ^spec, select: p.id) |> Repo.one!()
        Repo.insert(%ExpertSpecialities{pet_health_expert_id: e.id, pet_type_id: spec_id})
      end)
    end)

    alter table "pethealthexperts" do
      remove :specialities
    end
  end
end
