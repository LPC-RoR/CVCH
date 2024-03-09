require "application_system_test_case"

class EcoSetsTest < ApplicationSystemTestCase
  setup do
    @eco_set = eco_sets(:one)
  end

  test "visiting the index" do
    visit eco_sets_url
    assert_selector "h1", text: "Eco Sets"
  end

  test "creating a Eco set" do
    visit eco_sets_url
    click_on "New Eco Set"

    fill_in "Annio", with: @eco_set.annio
    fill_in "Coordenadas", with: @eco_set.coordenadas
    fill_in "Eco lugar", with: @eco_set.eco_lugar_id
    fill_in "Publicacion", with: @eco_set.publicacion_id
    click_on "Create Eco set"

    assert_text "Eco set was successfully created"
    click_on "Back"
  end

  test "updating a Eco set" do
    visit eco_sets_url
    click_on "Edit", match: :first

    fill_in "Annio", with: @eco_set.annio
    fill_in "Coordenadas", with: @eco_set.coordenadas
    fill_in "Eco lugar", with: @eco_set.eco_lugar_id
    fill_in "Publicacion", with: @eco_set.publicacion_id
    click_on "Update Eco set"

    assert_text "Eco set was successfully updated"
    click_on "Back"
  end

  test "destroying a Eco set" do
    visit eco_sets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Eco set was successfully destroyed"
  end
end
