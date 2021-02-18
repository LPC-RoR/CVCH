require "application_system_test_case"

class ObservacionesTest < ApplicationSystemTestCase
  setup do
    @observacion = observaciones(:one)
  end

  test "visiting the index" do
    visit observaciones_url
    assert_selector "h1", text: "Observaciones"
  end

  test "creating a Observacion" do
    visit observaciones_url
    click_on "New Observacion"

    fill_in "Detalle", with: @observacion.detalle
    fill_in "Observacion", with: @observacion.observacion
    fill_in "Publicacion", with: @observacion.publicacion_id
    click_on "Create Observacion"

    assert_text "Observacion was successfully created"
    click_on "Back"
  end

  test "updating a Observacion" do
    visit observaciones_url
    click_on "Edit", match: :first

    fill_in "Detalle", with: @observacion.detalle
    fill_in "Observacion", with: @observacion.observacion
    fill_in "Publicacion", with: @observacion.publicacion_id
    click_on "Update Observacion"

    assert_text "Observacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Observacion" do
    visit observaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Observacion was successfully destroyed"
  end
end
