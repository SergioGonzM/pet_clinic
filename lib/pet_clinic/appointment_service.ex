defmodule PetClinic.AppointmentService do
  @moduledoc """
  The AppointmentService context.
  """

  import Ecto.Query, warn: false
  alias PetClinic.Repo

  alias PetClinic.AppointmentService.Appointment

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
end
