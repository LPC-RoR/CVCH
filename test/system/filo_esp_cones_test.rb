require "application_system_test_case"

class FiloEspConesTest < ApplicationSystemTestCase
  setup do
    @filo_esp_con = filo_esp_cones(:one)
  end

  test "visiting the index" do
    visit filo_esp_cones_url
    assert_selector "h1", text: "Filo Esp Cones"
  end

  test "creating a Filo esp con" do
    visit filo_esp_cones_url
    click_on "New Filo Esp Con"

    fill_in "Filo categoria conservacion", with: @filo_esp_con.filo_categoria_conservacion_id
    fill_in "Filo especie", with: @filo_esp_con.filo_especie_id
    click_on "Create Filo esp con"

    assert_text "Filo esp con was successfully created"
    click_on "Back"
  end

  test "updating a Filo esp con" do
    visit filo_esp_cones_url
    click_on "Edit", match: :first

    fill_in "Filo categoria conservacion", with: @filo_esp_con.filo_categoria_conservacion_id
    fill_in "Filo especie", with: @filo_esp_con.filo_especie_id
    click_on "Update Filo esp con"

    assert_text "Filo esp con was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo esp con" do
    visit filo_esp_cones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo esp con was successfully destroyed"
  end
end
