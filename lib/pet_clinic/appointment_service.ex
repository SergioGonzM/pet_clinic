defmodule PetClinic.AppointmentService do
  @moduledoc """
  The AppointmentService context.
  """

  import Ecto.Query, warn: false
  alias PetClinic.Repo

  alias PetClinic.AppointmentService.Appointment
  alias PetClinic.PetClinicService.Pet

  @doc """
  Returns the list of appointments.

  ## Examples

      iex> list_appointments()
      [%Appointment{}, ...]

  """
  def list_appointments do
    Repo.all(Appointment)
  end

  @doc """
  Gets a single appointment.

  Raises `Ecto.NoResultsError` if the Appointment does not exist.

  ## Examples

      iex> get_appointment!(123)
      %Appointment{}

      iex> get_appointment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_appointment!(id), do: Repo.get!(Appointment, id)

  @doc """
  Creates a appointment.

  ## Examples

      iex> create_appointment(%{field: value})
      {:ok, %Appointment{}}

      iex> create_appointment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_appointment(attrs \\ %{}) do
    %Appointment{}
    |> Appointment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a appointment.

  ## Examples

      iex> update_appointment(appointment, %{field: new_value})
      {:ok, %Appointment{}}

      iex> update_appointment(appointment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_appointment(%Appointment{} = appointment, attrs) do
    appointment
    |> Appointment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a appointment.

  ## Examples

      iex> delete_appointment(appointment)
      {:ok, %Appointment{}}

      iex> delete_appointment(appointment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_appointment(%Appointment{} = appointment) do
    Repo.delete(appointment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking appointment changes.

  ## Examples

      iex> change_appointment(appointment)
      %Ecto.Changeset{data: %Appointment{}}

  """
  def change_appointment(%Appointment{} = appointment, attrs \\ %{}) do
    Appointment.changeset(appointment, attrs)
  end

  alias PetClinic.AppointmentService.ExpertSchedule

  @doc """
  Returns the list of expert_schedules.

  ## Examples

      iex> list_expert_schedules()
      [%ExpertSchedule{}, ...]

  """
  def list_expert_schedules do
    Repo.all(ExpertSchedule)
  end

  @doc """
  Gets a single expert_schedule.

  Raises `Ecto.NoResultsError` if the Expert schedule does not exist.

  ## Examples

      iex> get_expert_schedule!(123)
      %ExpertSchedule{}

      iex> get_expert_schedule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expert_schedule!(id), do: Repo.get!(ExpertSchedule, id)

  @doc """
  Creates a expert_schedule.

  ## Examples

      iex> create_expert_schedule(%{field: value})
      {:ok, %ExpertSchedule{}}

      iex> create_expert_schedule(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expert_schedule(attrs \\ %{}) do
    %ExpertSchedule{}
    |> ExpertSchedule.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expert_schedule.

  ## Examples

      iex> update_expert_schedule(expert_schedule, %{field: new_value})
      {:ok, %ExpertSchedule{}}

      iex> update_expert_schedule(expert_schedule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expert_schedule(%ExpertSchedule{} = expert_schedule, attrs) do
    expert_schedule
    |> ExpertSchedule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expert_schedule.

  ## Examples

      iex> delete_expert_schedule(expert_schedule)
      {:ok, %ExpertSchedule{}}

      iex> delete_expert_schedule(expert_schedule)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expert_schedule(%ExpertSchedule{} = expert_schedule) do
    Repo.delete(expert_schedule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expert_schedule changes.

  ## Examples

      iex> change_expert_schedule(expert_schedule)
      %Ecto.Changeset{data: %ExpertSchedule{}}

  """
  def change_expert_schedule(%ExpertSchedule{} = expert_schedule, attrs \\ %{}) do
    ExpertSchedule.changeset(expert_schedule, attrs)
  end

  def available_slots(expert_id, from_date, to_date) do
    # verificar si existe el experto
    schedule = Repo.get_by(ExpertSchedule, pet_health_expert_id: expert_id)

    cond do
      schedule == nil ->
        {:error, "expert with id #{expert_id} doesn't exist"}

      Date.compare(from_date, to_date) == :gt ->
        {:error, "wrong date range, are you from the future?"}

      true ->
        # |> Enum.map(fn x -> Time.truncate(x, :second) end)
        slots = block_hours(schedule.start_hour, schedule.end_hour)

        appointments =
          Repo.all(
            from a in Appointment,
              where: a.pet_health_expert_id == ^expert_id,
              select: [a.datetime]
          )

        slots_wo_appointments =
          Date.range(from_date, to_date)
          |> Map.new(fn d ->
            {d,
             slots
             |> Enum.filter(fn h -> [DateTime.new!(d, h)] not in appointments end)}
          end)

        slots_wo_appointments
    end
  end

  def new_appointment(expert_id, pet_id, datetime) do
    cond do
      Repo.get_by(ExpertSchedule, pet_health_expert_id: expert_id) == nil ->
        {:error, "expert with id #{expert_id} doesn't exist"}

      Repo.get_by(Pet, id: pet_id) == nil ->
        {:error, "pet with id #{pet_id} doesn't exist"}

      NaiveDateTime.compare(datetime, NaiveDateTime.local_now()) == :lt ->
        {:error, "datetime is in the past"}

      true ->
        date = NaiveDateTime.to_date(datetime)
        time = NaiveDateTime.to_time(datetime)
        spaces = available_slots(expert_id, date, date)

        if time in Map.get(spaces, date) do
          appointment = %Appointment{
            pet_id: pet_id,
            pet_health_expert_id: expert_id,
            datetime: DateTime.from_naive!(datetime, "Etc/UTC")
          }

          Repo.insert(appointment)
        else
          {:error, "Schedule not available or already busy, try another"}
        end
    end
  end

  def block_hours(start_hour, end_hour) do
    [start_hour, end_hour] =
      [start_hour, end_hour]
      |> Enum.map(fn x -> Time.to_seconds_after_midnight(x) end)
      |> Enum.map(fn e -> elem(e, 0) end)

    Enum.map(start_hour..end_hour//1800, fn x -> Time.from_seconds_after_midnight(x) end)
  end
end
