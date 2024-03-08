require "application_system_test_case"

class EcoFormacionesTest < ApplicationSystemTestCase
  setup do
    @eco_formacion = eco_formaciones(:one)
  end

  test "visiting the index" do
    visit eco_formaciones_url
    assert_selector "h1", text: "Eco Formaciones"
  end

  test "creating a Eco formacion" do
    visit eco_formaciones_url
    click_on "New Eco Formacion"

    fill_in "Eco formacion", with: @eco_formacion.eco_formacion
    click_on "Create Eco formacion"

    assert_text "Eco formacion was successfully created"
    click_on "Back"
  end

  test "updating a Eco formacion" do
    visit eco_formaciones_url
    click_on "Edit", match: :first

    fill_in "Eco formacion", with: @eco_formacion.eco_formacion
    click_on "Update Eco formacion"

    assert_text "Eco formacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Eco formacion" do
    visit eco_formaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Eco formacion was successfully destroyed"
  end
end
