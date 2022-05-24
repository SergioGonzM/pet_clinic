defmodule PetClinic.AppointmentServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.AppointmentService` context.
  """

  import PetClinic.PetClinicServiceFixtures

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    pet = pet_fixture()
    expert = pet_health_expert_fixture()

    {:ok, appointment} =
      attrs
      |> Enum.into(%{
        datetime: ~U[2022-04-26 01:58:00Z],
        pet_id: pet.id,
        expert_id: expert.id
      })
      |> PetClinic.AppointmentService.create_appointment()

    appointment
  end

  @doc """
  Generate a expert_schedule.
  """
  def expert_schedule_fixture(attrs \\ %{}) do
    {:ok, expert_schedule} =
      attrs
      |> Enum.into(%{
        end_hour: ~T[14:00:00],
        start_hour: ~T[14:00:00]
      })
      |> PetClinic.AppointmentService.create_expert_schedule()

    expert_schedule
  end
end
