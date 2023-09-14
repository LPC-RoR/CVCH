require "application_system_test_case"

class FiloFuentesTest < ApplicationSystemTestCase
  setup do
    @filo_fuente = filo_fuentes(:one)
  end

  test "visiting the index" do
    visit filo_fuentes_url
    assert_selector "h1", text: "Filo Fuentes"
  end

  test "creating a Filo fuente" do
    visit filo_fuentes_url
    click_on "New Filo Fuente"

    fill_in "Filo fuente", with: @filo_fuente.filo_fuente
    click_on "Create Filo fuente"

    assert_text "Filo fuente was successfully created"
    click_on "Back"
  end

  test "updating a Filo fuente" do
    visit filo_fuentes_url
    click_on "Edit", match: :first

    fill_in "Filo fuente", with: @filo_fuente.filo_fuente
    click_on "Update Filo fuente"

    assert_text "Filo fuente was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo fuente" do
    visit filo_fuentes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo fuente was successfully destroyed"
  end
end
