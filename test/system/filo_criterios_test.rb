require "application_system_test_case"

class FiloCriteriosTest < ApplicationSystemTestCase
  setup do
    @filo_criterio = filo_criterios(:one)
  end

  test "visiting the index" do
    visit filo_criterios_url
    assert_selector "h1", text: "Filo Criterios"
  end

  test "creating a Filo criterio" do
    visit filo_criterios_url
    click_on "New Filo Criterio"

    fill_in "Criterio", with: @filo_criterio.criterio
    fill_in "Filo conflicto", with: @filo_criterio.filo_conflicto_id
    fill_in "Fuente", with: @filo_criterio.fuente
    fill_in "Link fuente", with: @filo_criterio.link_fuente
    fill_in "Problema", with: @filo_criterio.problema
    click_on "Create Filo criterio"

    assert_text "Filo criterio was successfully created"
    click_on "Back"
  end

  test "updating a Filo criterio" do
    visit filo_criterios_url
    click_on "Edit", match: :first

    fill_in "Criterio", with: @filo_criterio.criterio
    fill_in "Filo conflicto", with: @filo_criterio.filo_conflicto_id
    fill_in "Fuente", with: @filo_criterio.fuente
    fill_in "Link fuente", with: @filo_criterio.link_fuente
    fill_in "Problema", with: @filo_criterio.problema
    click_on "Update Filo criterio"

    assert_text "Filo criterio was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo criterio" do
    visit filo_criterios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo criterio was successfully destroyed"
  end
end
