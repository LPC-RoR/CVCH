require "application_system_test_case"

class FiloInteraccionesTest < ApplicationSystemTestCase
  setup do
    @filo_interaccion = filo_interacciones(:one)
  end

  test "visiting the index" do
    visit filo_interacciones_url
    assert_selector "h1", text: "Filo Interacciones"
  end

  test "creating a Filo interaccion" do
    visit filo_interacciones_url
    click_on "New Filo Interaccion"

    fill_in "Filo def interaccion", with: @filo_interaccion.filo_def_interaccion_id
    fill_in "Publicacion", with: @filo_interaccion.publicacion_id
    click_on "Create Filo interaccion"

    assert_text "Filo interaccion was successfully created"
    click_on "Back"
  end

  test "updating a Filo interaccion" do
    visit filo_interacciones_url
    click_on "Edit", match: :first

    fill_in "Filo def interaccion", with: @filo_interaccion.filo_def_interaccion_id
    fill_in "Publicacion", with: @filo_interaccion.publicacion_id
    click_on "Update Filo interaccion"

    assert_text "Filo interaccion was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo interaccion" do
    visit filo_interacciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo interaccion was successfully destroyed"
  end
end
