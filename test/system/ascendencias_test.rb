require "application_system_test_case"

class AscendenciasTest < ApplicationSystemTestCase
  setup do
    @ascendencia = ascendencias(:one)
  end

  test "visiting the index" do
    visit ascendencias_url
    assert_selector "h1", text: "Ascendencias"
  end

  test "creating a Ascendencia" do
    visit ascendencias_url
    click_on "New Ascendencia"

    fill_in "Hijo", with: @ascendencia.hijo_id
    fill_in "Padre", with: @ascendencia.padre_id
    click_on "Create Ascendencia"

    assert_text "Ascendencia was successfully created"
    click_on "Back"
  end

  test "updating a Ascendencia" do
    visit ascendencias_url
    click_on "Edit", match: :first

    fill_in "Hijo", with: @ascendencia.hijo_id
    fill_in "Padre", with: @ascendencia.padre_id
    click_on "Update Ascendencia"

    assert_text "Ascendencia was successfully updated"
    click_on "Back"
  end

  test "destroying a Ascendencia" do
    visit ascendencias_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ascendencia was successfully destroyed"
  end
end
