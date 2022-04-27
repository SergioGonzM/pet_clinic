defmodule PetClinic.AppointmentService.ExpertSchedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expert_schedules" do
    field :end_hour, :time
    field :start_hour, :time

    

    timestamps()
  end

  @doc false
  def changeset(expert_schedule, attrs) do
    expert_schedule
    |> cast(attrs, [:start_hour, :end_hour])
    |> validate_required([:start_hour, :end_hour])
  end
end
