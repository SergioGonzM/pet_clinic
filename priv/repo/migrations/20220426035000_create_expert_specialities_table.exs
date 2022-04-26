defmodule PetClinic.Repo.Migrations.CreateExpertSpecialitiesTable do
  use Ecto.Migration

  def change do
    specialities = Repo.all(from h in PetHealthExpert, select: [h.id, h.specialities])

    create table "expert_specialities" do
      add :health_expert_id, references("pethealthexperts")
      add :pet_type_id, references("pet_types")
      timestamps()
    end

    flush()

    #primero necesito guardar las especialidades que ya estan en la bd:
    sp = all |> Enum.map(fn e -> [Enum.at(e, 0) | Enum.at(e, 1) |> String.split(",", trim: true)] end)
    |> Repo.insert(%{})


    #Segunda opcion
    #all |> Enum.map(fn e -> [w | a] = [Enum.at(e, 0) | Enum.at(e, 1) |> String.split(",", trim: true)] end)
    #de aqui solo faltaria hacer luego luego el Repo.insert(%ExpertSpecialities{pet_health_Expert_id: w, specialities: a})


    #Tercera opcion
    #all |> Enum.each(fn expert ->                                                  
     # expert_id = Enum.at(expert, 0)                                           
     # specialities = Enum.at(expert, 1) |> String.split([" ", ","], trim: true)end)
     #Y de aqui tambien hacer el repo.insert


    specialities |> Enum.each

    alter table "pethealthexperts" do
      remove
    end
  end
end
