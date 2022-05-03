defmodule PetClinicWeb.PetHealthExpertController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicService
  alias PetClinic.PetClinicService.PetHealthExpert

  def index(conn, _params) do
    pethealthexperts = PetClinicService.list_pethealthexperts()
    render(conn, "index.html", pethealthexperts: pethealthexperts)
  end

  def new(conn, _params) do
    changeset = PetClinicService.change_pet_health_expert(%PetHealthExpert{})
    pet_types = PetClinicService.list_pet_types()
    render(conn, "new.html", pet_types: pet_types, changeset: changeset)
  end

  def create(conn, %{"pet_health_expert" => pet_health_expert_params}) do
    pet_types = PetClinicService.list_pet_types()
    case PetClinicService.create_pet_health_expert(pet_health_expert_params) do
      {:ok, pet_health_expert} ->
        conn
        |> put_flash(:info, "Pet health expert created successfully.")
        |> redirect(to: Routes.pet_health_expert_path(conn, :show, pet_health_expert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", pet_types: pet_types, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pet_health_expert = PetClinicService.get_pet_health_expert!(id)
    render(conn, "show.html", pet_health_expert: pet_health_expert)
  end

  def edit(conn, %{"id" => id}) do
    pet_health_expert = PetClinicService.get_pet_health_expert!(id)
    pet_types = PetClinicService.list_pet_types()
    changeset = PetClinicService.change_pet_health_expert(pet_health_expert)
    render(conn, "edit.html", pet_health_expert: pet_health_expert, pet_types: pet_types, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pet_health_expert" => pet_health_expert_params}) do
    pet_health_expert = PetClinicService.get_pet_health_expert!(id)
    pet_types = PetClinicService.list_pet_types()
    case PetClinicService.update_pet_health_expert(pet_health_expert, pet_health_expert_params) do
      {:ok, pet_health_expert} ->
        conn
        |> put_flash(:info, "Pet health expert updated successfully.")
        |> redirect(to: Routes.pet_health_expert_path(conn, :show, pet_health_expert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pet_health_expert: pet_health_expert, pet_types: pet_types, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pet_health_expert = PetClinicService.get_pet_health_expert!(id)
    {:ok, _pet_health_expert} = PetClinicService.delete_pet_health_expert(pet_health_expert)

    conn
    |> put_flash(:info, "Pet health expert deleted successfully.")
    |> redirect(to: Routes.pet_health_expert_path(conn, :index))
  end

  def expert_appointments(conn, %{"id" => id, "date" => date})do
    date = Date.from_iso8601!(date)
    expert = PetClinicService.get_pet_health_expert!(id)
    appointments = PetClinicService.get_preload_expert!(id, preloads: [appointments: :pet])
    app = appointments |> Map.get(:appointments) 
    pet = Enum.map(app, fn p -> PetClinicService.get_pet!(p.pet_id) end)
    owner = Enum.map(pet, fn o -> PetClinicService.get_owner!(o.owner_id) end)

    app = app |> Enum.filter(fn ap -> ap.datetime 
      |> DateTime.to_date() 
      |> Date.compare(date) 
      |> case  do
        :eq -> true
        _ -> false
      end
    end)
    render(conn, "schedule_by_expert.html", expert: expert, owner: owner, pet: pet, app: app)
  end
end
