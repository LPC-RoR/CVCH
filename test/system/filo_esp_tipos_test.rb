require "application_system_test_case"

class FiloEspTiposTest < ApplicationSystemTestCase
  setup do
    @filo_esp_tipo = filo_esp_tipos(:one)
  end

  test "visiting the index" do
    visit filo_esp_tipos_url
    assert_selector "h1", text: "Filo Esp Tipos"
  end

  test "creating a Filo esp tipo" do
    visit filo_esp_tipos_url
    click_on "New Filo Esp Tipo"

    fill_in "Filo especie", with: @filo_esp_tipo.filo_especie_id
    fill_in "Filo tipo especie", with: @filo_esp_tipo.filo_tipo_especie_id
    click_on "Create Filo esp tipo"

    assert_text "Filo esp tipo was successfully created"
    click_on "Back"
  end

  test "updating a Filo esp tipo" do
    visit filo_esp_tipos_url
    click_on "Edit", match: :first

    fill_in "Filo especie", with: @filo_esp_tipo.filo_especie_id
    fill_in "Filo tipo especie", with: @filo_esp_tipo.filo_tipo_especie_id
    click_on "Update Filo esp tipo"

    assert_text "Filo esp tipo was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo esp tipo" do
    visit filo_esp_tipos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo esp tipo was successfully destroyed"
  end
end
