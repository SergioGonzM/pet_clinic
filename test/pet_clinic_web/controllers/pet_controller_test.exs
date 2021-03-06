defmodule PetClinicWeb.PetControllerTest do
  use PetClinicWeb.ConnCase

  import PetClinic.PetClinicServiceFixtures

  @invalid_attrs %{age: nil, name: nil, sex: nil, type: nil}

  describe "index" do
    test "lists all pets", %{conn: conn} do
      conn = get(conn, Routes.pet_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pets"
    end
  end

  describe "new pet" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pet_path(conn, :new))
      assert html_response(conn, 200) =~ "New Pet"
    end
  end

  describe "create pet" do
    test "redirects to show when data is valid", %{conn: conn} do
      pet_type = pet_type_fixture()
      preferred_expert = pet_health_expert_fixture()
      owner = owner_fixture()

      create_attrs = %{
        age: 42,
        name: "some name",
        sex: :male,
        type_id: pet_type.id,
        preferred_expert_id: preferred_expert.id,
        owner_id: owner.id
      }

      conn = post(conn, Routes.pet_path(conn, :create), pet: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.pet_path(conn, :show, id)

      conn = get(conn, Routes.pet_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Pet"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pet_path(conn, :create), pet: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pet"
    end
  end

  describe "edit pet" do
    setup [:create_pet]

    test "renders form for editing chosen pet", %{conn: conn, pet: pet} do
      conn = get(conn, Routes.pet_path(conn, :edit, pet))
      assert html_response(conn, 200) =~ "Edit Pet"
    end
  end

  describe "update pet" do
    setup [:create_pet]

    test "redirects when data is valid", %{conn: conn, pet: pet} do
      preferred_expert = pet_health_expert_fixture()

      update_attrs = %{
        age: 43,
        name: "some updated name",
        sex: :male,
        preferred_expert_id: preferred_expert.id
      }

      conn = put(conn, Routes.pet_path(conn, :update, pet), pet: update_attrs)
      assert redirected_to(conn) == Routes.pet_path(conn, :show, pet)

      conn = get(conn, Routes.pet_path(conn, :show, pet))
      assert html_response(conn, 200) =~ "some updated name"
    end

    # test "renders errors when data is invalid", %{conn: conn, pet: pet} do
    #   conn = put(conn, Routes.pet_path(conn, :update, pet), pet: @invalid_attrs)
    #   assert html_response(conn, 200) =~ "Edit Pet"
    # end
  end

  describe "delete pet" do
    setup [:create_pet]

    test "deletes chosen pet", %{conn: conn, pet: pet} do
      conn = delete(conn, Routes.pet_path(conn, :delete, pet))
      assert redirected_to(conn) == Routes.pet_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.pet_path(conn, :show, pet))
      end
    end
  end

  defp create_pet(_) do
    pet = pet_fixture()
    %{pet: pet}
  end
end
