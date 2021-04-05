require "application_system_test_case"

class IndPalabrasTest < ApplicationSystemTestCase
  setup do
    @ind_palabra = ind_palabras(:one)
  end

  test "visiting the index" do
    visit ind_palabras_url
    assert_selector "h1", text: "Ind Palabras"
  end

  test "creating a Ind palabra" do
    visit ind_palabras_url
    click_on "New Ind Palabra"

    fill_in "Ind clave", with: @ind_palabra.ind_clave_id
    fill_in "Ind lenguaje", with: @ind_palabra.ind_lenguaje_id
    fill_in "Ind palabra", with: @ind_palabra.ind_palabra
    click_on "Create Ind palabra"

    assert_text "Ind palabra was successfully created"
    click_on "Back"
  end

  test "updating a Ind palabra" do
    visit ind_palabras_url
    click_on "Edit", match: :first

    fill_in "Ind clave", with: @ind_palabra.ind_clave_id
    fill_in "Ind lenguaje", with: @ind_palabra.ind_lenguaje_id
    fill_in "Ind palabra", with: @ind_palabra.ind_palabra
    click_on "Update Ind palabra"

    assert_text "Ind palabra was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind palabra" do
    visit ind_palabras_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind palabra was successfully destroyed"
  end
end
