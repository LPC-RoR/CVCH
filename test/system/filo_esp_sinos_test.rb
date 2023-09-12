require "application_system_test_case"

class FiloEspSinosTest < ApplicationSystemTestCase
  setup do
    @filo_esp_sino = filo_esp_sinos(:one)
  end

  test "visiting the index" do
    visit filo_esp_sinos_url
    assert_selector "h1", text: "Filo Esp Sinos"
  end

  test "creating a Filo esp sino" do
    visit filo_esp_sinos_url
    click_on "New Filo Esp Sino"

    fill_in "Filo especie", with: @filo_esp_sino.filo_especie_id
    fill_in "Filo sinonimo", with: @filo_esp_sino.filo_sinonimo_id
    click_on "Create Filo esp sino"

    assert_text "Filo esp sino was successfully created"
    click_on "Back"
  end

  test "updating a Filo esp sino" do
    visit filo_esp_sinos_url
    click_on "Edit", match: :first

    fill_in "Filo especie", with: @filo_esp_sino.filo_especie_id
    fill_in "Filo sinonimo", with: @filo_esp_sino.filo_sinonimo_id
    click_on "Update Filo esp sino"

    assert_text "Filo esp sino was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo esp sino" do
    visit filo_esp_sinos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo esp sino was successfully destroyed"
  end
end
