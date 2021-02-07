require "application_system_test_case"

class DiccionariosTest < ApplicationSystemTestCase
  setup do
    @diccionario = diccionarios(:one)
  end

  test "visiting the index" do
    visit diccionarios_url
    assert_selector "h1", text: "Diccionarios"
  end

  test "creating a Diccionario" do
    visit diccionarios_url
    click_on "New Diccionario"

    fill_in "Concepto", with: @diccionario.concepto_id
    fill_in "Instancia", with: @diccionario.instancia_id
    click_on "Create Diccionario"

    assert_text "Diccionario was successfully created"
    click_on "Back"
  end

  test "updating a Diccionario" do
    visit diccionarios_url
    click_on "Edit", match: :first

    fill_in "Concepto", with: @diccionario.concepto_id
    fill_in "Instancia", with: @diccionario.instancia_id
    click_on "Update Diccionario"

    assert_text "Diccionario was successfully updated"
    click_on "Back"
  end

  test "destroying a Diccionario" do
    visit diccionarios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Diccionario was successfully destroyed"
  end
end
