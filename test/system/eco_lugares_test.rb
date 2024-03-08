require "application_system_test_case"

class EcoLugaresTest < ApplicationSystemTestCase
  setup do
    @eco_lugar = eco_lugares(:one)
  end

  test "visiting the index" do
    visit eco_lugares_url
    assert_selector "h1", text: "Eco Lugares"
  end

  test "creating a Eco lugar" do
    visit eco_lugares_url
    click_on "New Eco Lugar"

    fill_in "Coordenadas", with: @eco_lugar.coordenadas
    fill_in "Eco lugar", with: @eco_lugar.eco_lugar
    fill_in "Region", with: @eco_lugar.region_id
    click_on "Create Eco lugar"

    assert_text "Eco lugar was successfully created"
    click_on "Back"
  end

  test "updating a Eco lugar" do
    visit eco_lugares_url
    click_on "Edit", match: :first

    fill_in "Coordenadas", with: @eco_lugar.coordenadas
    fill_in "Eco lugar", with: @eco_lugar.eco_lugar
    fill_in "Region", with: @eco_lugar.region_id
    click_on "Update Eco lugar"

    assert_text "Eco lugar was successfully updated"
    click_on "Back"
  end

  test "destroying a Eco lugar" do
    visit eco_lugares_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Eco lugar was successfully destroyed"
  end
end
