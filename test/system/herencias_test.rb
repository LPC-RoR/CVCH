require "application_system_test_case"

class HerenciasTest < ApplicationSystemTestCase
  setup do
    @herencia = herencias(:one)
  end

  test "visiting the index" do
    visit herencias_url
    assert_selector "h1", text: "Herencias"
  end

  test "creating a Herencia" do
    visit herencias_url
    click_on "New Herencia"

    fill_in "Carpeta", with: @herencia.carpeta_id
    fill_in "Equipo", with: @herencia.equipo_id
    click_on "Create Herencia"

    assert_text "Herencia was successfully created"
    click_on "Back"
  end

  test "updating a Herencia" do
    visit herencias_url
    click_on "Edit", match: :first

    fill_in "Carpeta", with: @herencia.carpeta_id
    fill_in "Equipo", with: @herencia.equipo_id
    click_on "Update Herencia"

    assert_text "Herencia was successfully updated"
    click_on "Back"
  end

  test "destroying a Herencia" do
    visit herencias_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Herencia was successfully destroyed"
  end
end
