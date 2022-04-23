defmodule PetClinic.Repo.Migrations.FixingPetsSex do
  use Ecto.Migration
  alias PetClinic.Repo

  def change do
    query = "update pets set sex = lower(sex)"
    Ecto.Adapters.SQL.query!(Repo, query, [])

    query = "update pets set sex = 'female' where sex not in ('male', 'female')"
    Ecto.Adapters.SQL.query!(Repo, query, [])

    query = "update pethealthexperts set sex = lower(sex)"
    Ecto.Adapters.SQL.query!(Repo, query, [])

    query = "update pethealthexperts set sex = 'female' where sex not in ('male', 'female')"
    Ecto.Adapters.SQL.query!(Repo, query, [])
  end
end

