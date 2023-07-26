require "application_system_test_case"

class FiloTipoEspeciesTest < ApplicationSystemTestCase
  setup do
    @filo_tipo_especie = filo_tipo_especies(:one)
  end

  test "visiting the index" do
    visit filo_tipo_especies_url
    assert_selector "h1", text: "Filo Tipo Especies"
  end

  test "creating a Filo tipo especie" do
    visit filo_tipo_especies_url
    click_on "New Filo Tipo Especie"

    fill_in "Filo tipo especie", with: @filo_tipo_especie.filo_tipo_especie
    click_on "Create Filo tipo especie"

    assert_text "Filo tipo especie was successfully created"
    click_on "Back"
  end

  test "updating a Filo tipo especie" do
    visit filo_tipo_especies_url
    click_on "Edit", match: :first

    fill_in "Filo tipo especie", with: @filo_tipo_especie.filo_tipo_especie
    click_on "Update Filo tipo especie"

    assert_text "Filo tipo especie was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo tipo especie" do
    visit filo_tipo_especies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo tipo especie was successfully destroyed"
  end
end
