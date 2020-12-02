require "application_system_test_case"

class ConfiguracionesTest < ApplicationSystemTestCase
  setup do
    @configuracion = configuraciones(:one)
  end

  test "visiting the index" do
    visit configuraciones_url
    assert_selector "h1", text: "Configuraciones"
  end

  test "creating a Configuracion" do
    visit configuraciones_url
    click_on "New Configuracion"

    click_on "Create Configuracion"

    assert_text "Configuracion was successfully created"
    click_on "Back"
  end

  test "updating a Configuracion" do
    visit configuraciones_url
    click_on "Edit", match: :first

    click_on "Update Configuracion"

    assert_text "Configuracion was successfully updated"
    click_on "Back"
  end

  test "destroying a Configuracion" do
    visit configuraciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Configuracion was successfully destroyed"
  end
end
