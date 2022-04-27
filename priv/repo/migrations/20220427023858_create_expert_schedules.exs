defmodule PetClinic.Repo.Migrations.CreateExpertSchedules do
  use Ecto.Migration

  def change do
    create table("expert_schedules") do
      add :start_hour, :time
      add :end_hour, :time
      add :pet_health_expert_id, references("pethealthexperts")

      timestamps()
    end
  end
end
