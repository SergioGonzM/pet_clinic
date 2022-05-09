defmodule PetClinicWeb.ExpertScheduleControllerTest do
  use PetClinicWeb.ConnCase

  import PetClinic.AppointmentServiceFixtures

  @create_attrs %{end_hour: ~T[14:00:00], start_hour: ~T[14:00:00]}
  @update_attrs %{end_hour: ~T[15:01:01], start_hour: ~T[15:01:01]}
  @invalid_attrs %{end_hour: nil, start_hour: nil}

  describe "index" do
    test "lists all expert_schedules", %{conn: conn} do
      conn = get(conn, Routes.expert_schedule_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Expert schedules"
    end
  end

  describe "new expert_schedule" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.expert_schedule_path(conn, :new))
      assert html_response(conn, 200) =~ "New Expert schedule"
    end
  end

  describe "create expert_schedule" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.expert_schedule_path(conn, :create), expert_schedule: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.expert_schedule_path(conn, :show, id)

      conn = get(conn, Routes.expert_schedule_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Expert schedule"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.expert_schedule_path(conn, :create), expert_schedule: @invalid_attrs)

      assert html_response(conn, 200) =~ "New Expert schedule"
    end
  end

  describe "edit expert_schedule" do
    setup [:create_expert_schedule]

    test "renders form for editing chosen expert_schedule", %{
      conn: conn,
      expert_schedule: expert_schedule
    } do
      conn = get(conn, Routes.expert_schedule_path(conn, :edit, expert_schedule))
      assert html_response(conn, 200) =~ "Edit Expert schedule"
    end
  end

  describe "update expert_schedule" do
    setup [:create_expert_schedule]

    test "redirects when data is valid", %{conn: conn, expert_schedule: expert_schedule} do
      conn =
        put(conn, Routes.expert_schedule_path(conn, :update, expert_schedule),
          expert_schedule: @update_attrs
        )

      assert redirected_to(conn) == Routes.expert_schedule_path(conn, :show, expert_schedule)

      conn = get(conn, Routes.expert_schedule_path(conn, :show, expert_schedule))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, expert_schedule: expert_schedule} do
      conn =
        put(conn, Routes.expert_schedule_path(conn, :update, expert_schedule),
          expert_schedule: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Expert schedule"
    end
  end

  describe "delete expert_schedule" do
    setup [:create_expert_schedule]

    test "deletes chosen expert_schedule", %{conn: conn, expert_schedule: expert_schedule} do
      conn = delete(conn, Routes.expert_schedule_path(conn, :delete, expert_schedule))
      assert redirected_to(conn) == Routes.expert_schedule_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.expert_schedule_path(conn, :show, expert_schedule))
      end
    end
  end

  defp create_expert_schedule(_) do
    expert_schedule = expert_schedule_fixture()
    %{expert_schedule: expert_schedule}
  end
end
