defmodule PetClinic.PetClinicServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicService` context.
  """

  @doc """
  Generate a pet.
  """
  def pet_fixture(attrs \\ %{}) do
    pet_type = pet_type_fixture()
    owner = owner_fixture()

    {:ok, pet} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name",
        sex: :male,
        type_id: pet_type.id,
        owner_id: owner.id
      })
      |> PetClinic.PetClinicService.create_pet()

    pet
  end

  @doc """
  Generate a pet_health_expert.
  """
  def pet_health_expert_fixture(attrs \\ %{}) do
    {:ok, pet_health_expert} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        sex: :male
      })
      |> PetClinic.PetClinicService.create_pet_health_expert()

    pet_health_expert
  end

  @doc """
  Generate a owner.
  """
  def owner_fixture(attrs \\ %{}) do
    {:ok, owner} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        phone_num: "some phone_num"
      })
      |> PetClinic.PetClinicService.create_owner()

    owner
  end

  def pet_type_fixture(attrs \\ %{}) do
    {:ok, pet_type} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> PetClinic.PetClinicService.create_type()

    pet_type
  end
end
