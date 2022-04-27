defmodule PetClinicWeb.ExpertScheduleController do
  use PetClinicWeb, :controller

  alias PetClinic.AppointmentService
  alias PetClinic.AppointmentService.ExpertSchedule

  def index(conn, _params) do
    expert_schedules = AppointmentService.list_expert_schedules()
    render(conn, "index.html", expert_schedules: expert_schedules)
  end

  def new(conn, _params) do
    changeset = AppointmentService.change_expert_schedule(%ExpertSchedule{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"expert_schedule" => expert_schedule_params}) do
    case AppointmentService.create_expert_schedule(expert_schedule_params) do
      {:ok, expert_schedule} ->
        conn
        |> put_flash(:info, "Expert schedule created successfully.")
        |> redirect(to: Routes.expert_schedule_path(conn, :show, expert_schedule))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    expert_schedule = AppointmentService.get_expert_schedule!(id)
    render(conn, "show.html", expert_schedule: expert_schedule)
  end

  def edit(conn, %{"id" => id}) do
    expert_schedule = AppointmentService.get_expert_schedule!(id)
    changeset = AppointmentService.change_expert_schedule(expert_schedule)
    render(conn, "edit.html", expert_schedule: expert_schedule, changeset: changeset)
  end

  def update(conn, %{"id" => id, "expert_schedule" => expert_schedule_params}) do
    expert_schedule = AppointmentService.get_expert_schedule!(id)

    case AppointmentService.update_expert_schedule(expert_schedule, expert_schedule_params) do
      {:ok, expert_schedule} ->
        conn
        |> put_flash(:info, "Expert schedule updated successfully.")
        |> redirect(to: Routes.expert_schedule_path(conn, :show, expert_schedule))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", expert_schedule: expert_schedule, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    expert_schedule = AppointmentService.get_expert_schedule!(id)
    {:ok, _expert_schedule} = AppointmentService.delete_expert_schedule(expert_schedule)

    conn
    |> put_flash(:info, "Expert schedule deleted successfully.")
    |> redirect(to: Routes.expert_schedule_path(conn, :index))
  end
end
