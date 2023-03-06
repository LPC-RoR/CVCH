require "application_system_test_case"

class FiloEspEspsTest < ApplicationSystemTestCase
  setup do
    @filo_esp_esp = filo_esp_esps(:one)
  end

  test "visiting the index" do
    visit filo_esp_esps_url
    assert_selector "h1", text: "Filo Esp Esps"
  end

  test "creating a Filo esp esp" do
    visit filo_esp_esps_url
    click_on "New Filo Esp Esp"

    fill_in "Child", with: @filo_esp_esp.child_id
    fill_in "Parent", with: @filo_esp_esp.parent_id
    click_on "Create Filo esp esp"

    assert_text "Filo esp esp was successfully created"
    click_on "Back"
  end

  test "updating a Filo esp esp" do
    visit filo_esp_esps_url
    click_on "Edit", match: :first

    fill_in "Child", with: @filo_esp_esp.child_id
    fill_in "Parent", with: @filo_esp_esp.parent_id
    click_on "Update Filo esp esp"

    assert_text "Filo esp esp was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo esp esp" do
    visit filo_esp_esps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo esp esp was successfully destroyed"
  end
end
