require "application_system_test_case"

class RutasTest < ApplicationSystemTestCase
  setup do
    @ruta = rutas(:one)
  end

  test "visiting the index" do
    visit rutas_url
    assert_selector "h1", text: "Rutas"
  end

  test "creating a Ruta" do
    visit rutas_url
    click_on "New Ruta"

    fill_in "Instancia", with: @ruta.instancia_id
    fill_in "Publicacion", with: @ruta.publicacion_id
    click_on "Create Ruta"

    assert_text "Ruta was successfully created"
    click_on "Back"
  end

  test "updating a Ruta" do
    visit rutas_url
    click_on "Edit", match: :first

    fill_in "Instancia", with: @ruta.instancia_id
    fill_in "Publicacion", with: @ruta.publicacion_id
    click_on "Update Ruta"

    assert_text "Ruta was successfully updated"
    click_on "Back"
  end

  test "destroying a Ruta" do
    visit rutas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ruta was successfully destroyed"
  end
end
