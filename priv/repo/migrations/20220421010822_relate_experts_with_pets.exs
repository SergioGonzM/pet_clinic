defmodule PetClinic.Repo.Migrations.RelateExpertsWithPet do
  use Ecto.Migration

  def change do
    alter table("pets") do
      add :preferred_expert_id, references("pethealthexperts")
    end
  end
end
