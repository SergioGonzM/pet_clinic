defmodule PetClinicWeb.AppointmentController do
  use PetClinicWeb, :controller

  alias PetClinic.AppointmentService
  alias PetClinic.AppointmentService.Appointment

  def index(conn, _params) do
    appointments = AppointmentService.list_appointments()
    render(conn, "index.html", appointments: appointments)
  end

  def new(conn, _params) do
    changeset = AppointmentService.change_appointment(%Appointment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"appointment" => appointment_params}) do
    case AppointmentService.create_appointment(appointment_params) do
      {:ok, appointment} ->
        conn
        |> put_flash(:info, "Appointment created successfully.")
        |> redirect(to: Routes.appointment_path(conn, :show, appointment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    appointment = AppointmentService.get_appointment!(id)
    render(conn, "show.html", appointment: appointment)
  end

  def edit(conn, %{"id" => id}) do
    appointment = AppointmentService.get_appointment!(id)
    changeset = AppointmentService.change_appointment(appointment)
    render(conn, "edit.html", appointment: appointment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "appointment" => appointment_params}) do
    appointment = AppointmentService.get_appointment!(id)

    case AppointmentService.update_appointment(appointment, appointment_params) do
      {:ok, appointment} ->
        conn
        |> put_flash(:info, "Appointment updated successfully.")
        |> redirect(to: Routes.appointment_path(conn, :show, appointment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", appointment: appointment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    appointment = AppointmentService.get_appointment!(id)
    {:ok, _appointment} = AppointmentService.delete_appointment(appointment)

    conn
    |> put_flash(:info, "Appointment deleted successfully.")
    |> redirect(to: Routes.appointment_path(conn, :index))
  end
end
