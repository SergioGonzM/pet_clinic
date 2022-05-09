defmodule PetClinicWeb.Router do
  use PetClinicWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PetClinicWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PetClinicWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/bar", PageController, :bar
  end

  scope "/", PetClinicWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/bar", PageController, :bar
    get "/pets/by_type/:type", PetController, :index_by_type
    get "/pethealthexperts/:id/schedule", PetHealthExpertController, :expert_appointments

    resources "/pets", PetController
    resources "/pethealthexperts", PetHealthExpertController
    resources "/owners", OwnerController
    resources "/appointments", AppointmentController
    resources "/expert_schedules", ExpertScheduleController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PetClinicWeb do
  #   pipe_through :api
  # end
end
