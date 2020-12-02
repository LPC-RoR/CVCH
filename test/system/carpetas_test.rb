require "application_system_test_case"

class CarpetasTest < ApplicationSystemTestCase
  setup do
    @carpeta = carpetas(:one)
  end

  test "visiting the index" do
    visit carpetas_url
    assert_selector "h1", text: "Carpetas"
  end

  test "creating a Carpeta" do
    visit carpetas_url
    click_on "New Carpeta"

    fill_in "Carpeta", with: @carpeta.carpeta
    fill_in "Equipo", with: @carpeta.equipo_id
    fill_in "Investigador", with: @carpeta.investigador_id
    click_on "Create Carpeta"

    assert_text "Carpeta was successfully created"
    click_on "Back"
  end

  test "updating a Carpeta" do
    visit carpetas_url
    click_on "Edit", match: :first

    fill_in "Carpeta", with: @carpeta.carpeta
    fill_in "Equipo", with: @carpeta.equipo_id
    fill_in "Investigador", with: @carpeta.investigador_id
    click_on "Update Carpeta"

    assert_text "Carpeta was successfully updated"
    click_on "Back"
  end

  test "destroying a Carpeta" do
    visit carpetas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Carpeta was successfully destroyed"
  end
end
