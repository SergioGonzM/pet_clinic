defmodule PetClinic.AppointmentServiceTest do
  use PetClinic.DataCase

  alias PetClinic.AppointmentService

  describe "appointments" do
    alias PetClinic.AppointmentService.Appointment

    import PetClinic.AppointmentServiceFixtures

    @invalid_attrs %{datetime: nil}

    test "list_appointments/0 returns all appointments" do
      appointment = appointment_fixture()
      assert AppointmentService.list_appointments() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert AppointmentService.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      valid_attrs = %{datetime: ~U[2022-04-26 01:58:00Z]}

      assert {:ok, %Appointment{} = _appointment} =
               AppointmentService.create_appointment(valid_attrs)
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AppointmentService.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()
      update_attrs = %{}

      assert {:ok, %Appointment{} = _appointment} =
               AppointmentService.update_appointment(appointment, update_attrs)
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AppointmentService.update_appointment(appointment, @invalid_attrs)

      assert appointment == AppointmentService.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = AppointmentService.delete_appointment(appointment)

      assert_raise Ecto.NoResultsError, fn ->
        AppointmentService.get_appointment!(appointment.id)
      end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = AppointmentService.change_appointment(appointment)
    end
  end

  describe "expert_schedules" do
    alias PetClinic.AppointmentService.ExpertSchedule

    import PetClinic.AppointmentServiceFixtures

    @invalid_attrs %{end_hour: nil, start_hour: nil}

    test "list_expert_schedules/0 returns all expert_schedules" do
      expert_schedule = expert_schedule_fixture()
      assert AppointmentService.list_expert_schedules() == [expert_schedule]
    end

    test "get_expert_schedule!/1 returns the expert_schedule with given id" do
      expert_schedule = expert_schedule_fixture()
      assert AppointmentService.get_expert_schedule!(expert_schedule.id) == expert_schedule
    end

    test "create_expert_schedule/1 with valid data creates a expert_schedule" do
      valid_attrs = %{end_hour: ~T[14:00:00], start_hour: ~T[14:00:00]}

      assert {:ok, %ExpertSchedule{} = expert_schedule} =
               AppointmentService.create_expert_schedule(valid_attrs)

      assert expert_schedule.end_hour == ~T[14:00:00]
      assert expert_schedule.start_hour == ~T[14:00:00]
    end

    test "create_expert_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               AppointmentService.create_expert_schedule(@invalid_attrs)
    end

    test "update_expert_schedule/2 with valid data updates the expert_schedule" do
      expert_schedule = expert_schedule_fixture()
      update_attrs = %{end_hour: ~T[15:01:01], start_hour: ~T[15:01:01]}

      assert {:ok, %ExpertSchedule{} = expert_schedule} =
               AppointmentService.update_expert_schedule(expert_schedule, update_attrs)

      assert expert_schedule.end_hour == ~T[15:01:01]
      assert expert_schedule.start_hour == ~T[15:01:01]
    end

    test "update_expert_schedule/2 with invalid data returns error changeset" do
      expert_schedule = expert_schedule_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AppointmentService.update_expert_schedule(expert_schedule, @invalid_attrs)

      assert expert_schedule == AppointmentService.get_expert_schedule!(expert_schedule.id)
    end

    test "delete_expert_schedule/1 deletes the expert_schedule" do
      expert_schedule = expert_schedule_fixture()
      assert {:ok, %ExpertSchedule{}} = AppointmentService.delete_expert_schedule(expert_schedule)

      assert_raise Ecto.NoResultsError, fn ->
        AppointmentService.get_expert_schedule!(expert_schedule.id)
      end
    end

    test "change_expert_schedule/1 returns a expert_schedule changeset" do
      expert_schedule = expert_schedule_fixture()
      assert %Ecto.Changeset{} = AppointmentService.change_expert_schedule(expert_schedule)
    end
  end
end
