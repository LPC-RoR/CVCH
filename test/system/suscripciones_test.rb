require "application_system_test_case"

class SuscripcionesTest < ApplicationSystemTestCase
  setup do
    @suscripcion = suscripciones(:one)
  end

  test "visiting the index" do
    visit suscripciones_url
    assert_selector "h1", text: "Suscripciones"
  end

  test "creating a Suscripcion" do
    visit suscripciones_url
    click_on "New Suscripcion"

    fill_in "Categoria", with: @suscripcion.categoria_id
    fill_in "Perfil", with: @suscripcion.perfil_id
    click_on "Create Suscripcion"

    assert_text "Suscripcion was successfully created"
    click_on "Back"
  end

  test "updating a Suscripcion" do
    visit suscripciones_url
    click_on "Edit", match: :first

    fill_in "Categoria", with: @suscripcion.categoria_id
    fill_in "Perfil", with: @suscripcion.perfil_id
    click_on "Update Suscripcion"

    assert_text "Suscripcion was successfully updated"
    click_on "Back"
  end

  test "destroying a Suscripcion" do
    visit suscripciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Suscripcion was successfully destroyed"
  end
end
