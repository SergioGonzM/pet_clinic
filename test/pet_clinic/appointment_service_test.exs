defmodule PetClinic.AppointmentServiceTest do
  use PetClinic.DataCase

  alias PetClinic.AppointmentService

  describe "appointments" do
    alias PetClinic.AppointmentService.Appointment

    import PetClinic.AppointmentServiceFixtures

    @invalid_attrs %{}

    test "list_appointments/0 returns all appointments" do
      appointment = appointment_fixture()
      assert AppointmentService.list_appointments() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert AppointmentService.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      valid_attrs = %{}

      assert {:ok, %Appointment{} = appointment} = AppointmentService.create_appointment(valid_attrs)
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AppointmentService.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()
      update_attrs = %{}

      assert {:ok, %Appointment{} = appointment} = AppointmentService.update_appointment(appointment, update_attrs)
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()
      assert {:error, %Ecto.Changeset{}} = AppointmentService.update_appointment(appointment, @invalid_attrs)
      assert appointment == AppointmentService.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = AppointmentService.delete_appointment(appointment)
      assert_raise Ecto.NoResultsError, fn -> AppointmentService.get_appointment!(appointment.id) end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = AppointmentService.change_appointment(appointment)
    end
  end
end
