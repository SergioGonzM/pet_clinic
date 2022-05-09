defmodule PetClinic.PetClinicService do
  @moduledoc """
  The PetClinicService context.
  """

  import Ecto.Query, warn: false
  alias PetClinic.Repo

  alias PetClinic.PetClinicService.Pet
  alias PetClinic.PetClinicService.PetType

  @doc """
  Returns the list of pets.

  ## Examples

      iex> list_pets()
      [%Pet{}, ...]

  """
  def list_pets do
    Repo.all(Pet) |> Repo.preload(:type)
  end

  @doc """
  Gets a single pet.

  Raises `Ecto.NoResultsError` if the Pet does not exist.

  ## Examples

      iex> get_pet!(123)
      %Pet{}

      iex> get_pet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pet!(id), do: Repo.get!(Pet, id) |> Repo.preload(:type)

  @doc """
  Creates a pet.

  ## Examples

      iex> create_pet(%{field: value})
      {:ok, %Pet{}}

      iex> create_pet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pet(attrs \\ %{}) do
    %Pet{}
    |> Pet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pet.

  ## Examples

      iex> update_pet(pet, %{field: new_value})
      {:ok, %Pet{}}

      iex> update_pet(pet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pet(%Pet{} = pet, attrs) do
    pet
    |> Pet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pet.

  ## Examples

      iex> delete_pet(pet)
      {:ok, %Pet{}}

      iex> delete_pet(pet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pet(%Pet{} = pet) do
    Repo.delete(pet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pet changes.

  ## Examples

      iex> change_pet(pet)
      %Ecto.Changeset{data: %Pet{}}

  """
  def change_pet(%Pet{} = pet, attrs \\ %{}) do
    Pet.changeset(pet, attrs)
  end

  def list_pets_by_type(type) do
    Repo.all(from p in Pet, where: p.type == ^type)
  end

  alias PetClinic.PetClinicService.PetHealthExpert

  @doc """
  Returns the list of pethealthexperts.

  ## Examples

      iex> list_pethealthexperts()
      [%PetHealthExpert{}, ...]

  """
  def list_pethealthexperts do
    Repo.all(PetHealthExpert) |> Repo.preload(:specialities)
  end

  @doc """
  Gets a single pet_health_expert.

  Raises `Ecto.NoResultsError` if the Pet health expert does not exist.

  ## Examples

      iex> get_pet_health_expert!(123)
      %PetHealthExpert{}

      iex> get_pet_health_expert!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pet_health_expert!(id),
    do: Repo.get!(PetHealthExpert, id) |> Repo.preload(:specialities)

  def get_preload_expert!(id, preloads: preloads) do
    Repo.get!(PetHealthExpert, id) |> Repo.preload(preloads)
  end

  @doc """
  Creates a pet_health_expert.

  ## Examples

      iex> create_pet_health_expert(%{field: value})
      {:ok, %PetHealthExpert{}}

      iex> create_pet_health_expert(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pet_health_expert(attrs \\ %{}) do
    %PetHealthExpert{}
    |> PetHealthExpert.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pet_health_expert.

  ## Examples

      iex> update_pet_health_expert(pet_health_expert, %{field: new_value})
      {:ok, %PetHealthExpert{}}

      iex> update_pet_health_expert(pet_health_expert, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pet_health_expert(%PetHealthExpert{} = pet_health_expert, attrs) do
    pet_health_expert
    |> PetHealthExpert.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pet_health_expert.

  ## Examples

      iex> delete_pet_health_expert(pet_health_expert)
      {:ok, %PetHealthExpert{}}

      iex> delete_pet_health_expert(pet_health_expert)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pet_health_expert(%PetHealthExpert{} = pet_health_expert) do
    Repo.delete(pet_health_expert)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pet_health_expert changes.

  ## Examples

      iex> change_pet_health_expert(pet_health_expert)
      %Ecto.Changeset{data: %PetHealthExpert{}}

  """
  def change_pet_health_expert(%PetHealthExpert{} = pet_health_expert, attrs \\ %{}) do
    PetHealthExpert.changeset(pet_health_expert, attrs)
  end

  alias PetClinic.PetClinicService.Owner

  @doc """
  Returns the list of owners.

  ## Examples

      iex> list_owners()
      [%Owner{}, ...]

  """
  def list_owners do
    Repo.all(Owner)
  end

  @doc """
  Gets a single owner.

  Raises `Ecto.NoResultsError` if the Owner does not exist.

  ## Examples

      iex> get_owner!(123)
      %Owner{}

      iex> get_owner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_owner!(id), do: Repo.get!(Owner, id)

  @doc """
  Creates a owner.

  ## Examples

      iex> create_owner(%{field: value})
      {:ok, %Owner{}}

      iex> create_owner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_owner(attrs \\ %{}) do
    %Owner{}
    |> Owner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a owner.

  ## Examples

      iex> update_owner(owner, %{field: new_value})
      {:ok, %Owner{}}

      iex> update_owner(owner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_owner(%Owner{} = owner, attrs) do
    owner
    |> Owner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a owner.

  ## Examples

      iex> delete_owner(owner)
      {:ok, %Owner{}}

      iex> delete_owner(owner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_owner(%Owner{} = owner) do
    Repo.delete(owner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking owner changes.

  ## Examples

      iex> change_owner(owner)
      %Ecto.Changeset{data: %Owner{}}

  """
  def change_owner(%Owner{} = owner, attrs \\ %{}) do
    Owner.changeset(owner, attrs)
  end

  def list_pet_types() do
    Repo.all(PetType)
  end
end
