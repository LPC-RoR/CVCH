require "application_system_test_case"

class FiloDefRolInteraccionesTest < ApplicationSystemTestCase
  setup do
    @filo_def_rol_interaccion = filo_def_rol_interacciones(:one)
  end

  test "visiting the index" do
    visit filo_def_rol_interacciones_url
    assert_selector "h1", text: "Filo Def Rol Interacciones"
  end

  test "creating a Filo def rol interaccion" do
    visit filo_def_rol_interacciones_url
    click_on "New Filo Def Rol Interaccion"

    fill_in "Rol a", with: @filo_def_rol_interaccion.rol_a_id
    fill_in "Rol b", with: @filo_def_rol_interaccion.rol_b_id
    click_on "Create Filo def rol interaccion"

    assert_text "Filo def rol interaccion was successfully created"
    click_on "Back"
  end

  test "updating a Filo def rol interaccion" do
    visit filo_def_rol_interacciones_url
    click_on "Edit", match: :first

    fill_in "Rol a", with: @filo_def_rol_interaccion.rol_a_id
    fill_in "Rol b", with: @filo_def_rol_interaccion.rol_b_id
    click_on "Update Filo def rol interaccion"

    assert_text "Filo def rol interaccion was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo def rol interaccion" do
    visit filo_def_rol_interacciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo def rol interaccion was successfully destroyed"
  end
end
