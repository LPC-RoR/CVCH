require "application_system_test_case"

class FiloRolesTest < ApplicationSystemTestCase
  setup do
    @filo_rol = filo_roles(:one)
  end

  test "visiting the index" do
    visit filo_roles_url
    assert_selector "h1", text: "Filo Roles"
  end

  test "creating a Filo rol" do
    visit filo_roles_url
    click_on "New Filo Rol"

    fill_in "Filo especie", with: @filo_rol.filo_especie_id
    fill_in "Filo interaccion", with: @filo_rol.filo_interaccion_id
    fill_in "Filo rol", with: @filo_rol.filo_rol
    click_on "Create Filo rol"

    assert_text "Filo rol was successfully created"
    click_on "Back"
  end

  test "updating a Filo rol" do
    visit filo_roles_url
    click_on "Edit", match: :first

    fill_in "Filo especie", with: @filo_rol.filo_especie_id
    fill_in "Filo interaccion", with: @filo_rol.filo_interaccion_id
    fill_in "Filo rol", with: @filo_rol.filo_rol
    click_on "Update Filo rol"

    assert_text "Filo rol was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo rol" do
    visit filo_roles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo rol was successfully destroyed"
  end
end
