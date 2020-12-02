require "application_system_test_case"

class ClasificacionesTest < ApplicationSystemTestCase
  setup do
    @clasificacion = clasificaciones(:one)
  end

  test "visiting the index" do
    visit clasificaciones_url
    assert_selector "h1", text: "Clasificaciones"
  end

  test "creating a Clasificacion" do
    visit clasificaciones_url
    click_on "New Clasificacion"

    fill_in "Carpeta", with: @clasificacion.carpeta_id
    fill_in "Publicacion", with: @clasificacion.publicacion_id
    click_on "Create Clasificacion"

    assert_text "Clasificacion was successfully created"
    click_on "Back"
  end

  test "updating a Clasificacion" do
    visit clasificaciones_url
    click_on "Edit", match: :first

    fill_in "Carpeta", with: @clasificacion.carpeta_id
    fill_in "Publicacion", with: @clasificacion.publicacion_id
    click_on "Update Clasificacion"

    assert_text "Clasificacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Clasificacion" do
    visit clasificaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Clasificacion was successfully destroyed"
  end
end
