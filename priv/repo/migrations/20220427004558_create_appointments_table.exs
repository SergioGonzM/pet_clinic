defmodule PetClinic.Repo.Migrations.CreateAppointmentsTable do
  use Ecto.Migration

  def change do
    create table("appointments") do
      add :pet_id, references("pets")
      add :pet_health_expert_id, references("pethealthexperts")
      add :datetime, :utc_datetime

      timestamps()
    end
  end
end
