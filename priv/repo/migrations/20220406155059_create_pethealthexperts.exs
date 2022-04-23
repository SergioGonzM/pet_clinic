defmodule PetClinic.Repo.Migrations.CreatePethealthexperts do
  use Ecto.Migration

  def change do
    create table(:pethealthexperts) do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :specialities, :string
      add :sex, :string

      timestamps()
    end
  end
end
