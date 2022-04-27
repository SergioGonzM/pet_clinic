defmodule PetClinic.AppointmentServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.AppointmentService` context.
  """

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    {:ok, appointment} =
      attrs
      |> Enum.into(%{

      })
      |> PetClinic.AppointmentService.create_appointment()

    appointment
  end
end
