require "application_system_test_case"

class FiloEspeciesTest < ApplicationSystemTestCase
  setup do
    @filo_especie = filo_especies(:one)
  end

  test "visiting the index" do
    visit filo_especies_url
    assert_selector "h1", text: "Filo Especies"
  end

  test "creating a Filo especie" do
    visit filo_especies_url
    click_on "New Filo Especie"

    fill_in "Filo especie", with: @filo_especie.filo_especie
    fill_in "Iucn", with: @filo_especie.iucn
    fill_in "Nombre comun", with: @filo_especie.nombre_comun
    click_on "Create Filo especie"

    assert_text "Filo especie was successfully created"
    click_on "Back"
  end

  test "updating a Filo especie" do
    visit filo_especies_url
    click_on "Edit", match: :first

    fill_in "Filo especie", with: @filo_especie.filo_especie
    fill_in "Iucn", with: @filo_especie.iucn
    fill_in "Nombre comun", with: @filo_especie.nombre_comun
    click_on "Update Filo especie"

    assert_text "Filo especie was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo especie" do
    visit filo_especies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo especie was successfully destroyed"
  end
end
