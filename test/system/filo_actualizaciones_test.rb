require "application_system_test_case"

class FiloActualizacionesTest < ApplicationSystemTestCase
  setup do
    @filo_actualizacion = filo_actualizaciones(:one)
  end

  test "visiting the index" do
    visit filo_actualizaciones_url
    assert_selector "h1", text: "Filo Actualizaciones"
  end

  test "creating a Filo actualizacion" do
    visit filo_actualizaciones_url
    click_on "New Filo Actualizacion"

    fill_in "App perfil", with: @filo_actualizacion.app_perfil_id
    fill_in "Filo fuente", with: @filo_actualizacion.filo_fuente_id
    fill_in "Link fuentesinonimia", with: @filo_actualizacion.link_fuentesinonimia
    fill_in "Nombre comun", with: @filo_actualizacion.nombre_comun
    fill_in "Referencia", with: @filo_actualizacion.referencia
    click_on "Create Filo actualizacion"

    assert_text "Filo actualizacion was successfully created"
    click_on "Back"
  end

  test "updating a Filo actualizacion" do
    visit filo_actualizaciones_url
    click_on "Edit", match: :first

    fill_in "App perfil", with: @filo_actualizacion.app_perfil_id
    fill_in "Filo fuente", with: @filo_actualizacion.filo_fuente_id
    fill_in "Link fuentesinonimia", with: @filo_actualizacion.link_fuentesinonimia
    fill_in "Nombre comun", with: @filo_actualizacion.nombre_comun
    fill_in "Referencia", with: @filo_actualizacion.referencia
    click_on "Update Filo actualizacion"

    assert_text "Filo actualizacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo actualizacion" do
    visit filo_actualizaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo actualizacion was successfully destroyed"
  end
end
