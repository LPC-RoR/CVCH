require "application_system_test_case"

class FiloDefRolesTest < ApplicationSystemTestCase
  setup do
    @filo_def_rol = filo_def_roles(:one)
  end

  test "visiting the index" do
    visit filo_def_roles_url
    assert_selector "h1", text: "Filo Def Roles"
  end

  test "creating a Filo def rol" do
    visit filo_def_roles_url
    click_on "New Filo Def Rol"

    fill_in "Filo def rol", with: @filo_def_rol.filo_def_rol
    click_on "Create Filo def rol"

    assert_text "Filo def rol was successfully created"
    click_on "Back"
  end

  test "updating a Filo def rol" do
    visit filo_def_roles_url
    click_on "Edit", match: :first

    fill_in "Filo def rol", with: @filo_def_rol.filo_def_rol
    click_on "Update Filo def rol"

    assert_text "Filo def rol was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo def rol" do
    visit filo_def_roles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo def rol was successfully destroyed"
  end
end
