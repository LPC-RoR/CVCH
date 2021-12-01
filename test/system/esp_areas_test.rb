require "application_system_test_case"

class EspAreasTest < ApplicationSystemTestCase
  setup do
    @esp_area = esp_areas(:one)
  end

  test "visiting the index" do
    visit esp_areas_url
    assert_selector "h1", text: "Esp Areas"
  end

  test "creating a Esp area" do
    visit esp_areas_url
    click_on "New Esp Area"

    fill_in "Area", with: @esp_area.area_id
    fill_in "Especie", with: @esp_area.especie_id
    click_on "Create Esp area"

    assert_text "Esp area was successfully created"
    click_on "Back"
  end

  test "updating a Esp area" do
    visit esp_areas_url
    click_on "Edit", match: :first

    fill_in "Area", with: @esp_area.area_id
    fill_in "Especie", with: @esp_area.especie_id
    click_on "Update Esp area"

    assert_text "Esp area was successfully updated"
    click_on "Back"
  end

  test "destroying a Esp area" do
    visit esp_areas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Esp area was successfully destroyed"
  end
end
