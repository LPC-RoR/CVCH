require "application_system_test_case"

class EcoPisosTest < ApplicationSystemTestCase
  setup do
    @eco_piso = eco_pisos(:one)
  end

  test "visiting the index" do
    visit eco_pisos_url
    assert_selector "h1", text: "Eco Pisos"
  end

  test "creating a Eco piso" do
    visit eco_pisos_url
    click_on "New Eco Piso"

    fill_in "Eco formacion", with: @eco_piso.eco_formacion_id
    fill_in "Eco piso", with: @eco_piso.eco_piso
    click_on "Create Eco piso"

    assert_text "Eco piso was successfully created"
    click_on "Back"
  end

  test "updating a Eco piso" do
    visit eco_pisos_url
    click_on "Edit", match: :first

    fill_in "Eco formacion", with: @eco_piso.eco_formacion_id
    fill_in "Eco piso", with: @eco_piso.eco_piso
    click_on "Update Eco piso"

    assert_text "Eco piso was successfully updated"
    click_on "Back"
  end

  test "destroying a Eco piso" do
    visit eco_pisos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Eco piso was successfully destroyed"
  end
end
