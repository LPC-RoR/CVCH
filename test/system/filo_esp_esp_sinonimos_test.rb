require "application_system_test_case"

class FiloEspEspSinonimosTest < ApplicationSystemTestCase
  setup do
    @filo_esp_esp_sinonimo = filo_esp_esp_sinonimos(:one)
  end

  test "visiting the index" do
    visit filo_esp_esp_sinonimos_url
    assert_selector "h1", text: "Filo Esp Esp Sinonimos"
  end

  test "creating a Filo esp esp sinonimo" do
    visit filo_esp_esp_sinonimos_url
    click_on "New Filo Esp Esp Sinonimo"

    fill_in "Especie", with: @filo_esp_esp_sinonimo.especie_id
    fill_in "Sinonimo", with: @filo_esp_esp_sinonimo.sinonimo_id
    click_on "Create Filo esp esp sinonimo"

    assert_text "Filo esp esp sinonimo was successfully created"
    click_on "Back"
  end

  test "updating a Filo esp esp sinonimo" do
    visit filo_esp_esp_sinonimos_url
    click_on "Edit", match: :first

    fill_in "Especie", with: @filo_esp_esp_sinonimo.especie_id
    fill_in "Sinonimo", with: @filo_esp_esp_sinonimo.sinonimo_id
    click_on "Update Filo esp esp sinonimo"

    assert_text "Filo esp esp sinonimo was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo esp esp sinonimo" do
    visit filo_esp_esp_sinonimos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo esp esp sinonimo was successfully destroyed"
  end
end
