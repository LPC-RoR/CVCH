require "application_system_test_case"

class TemaAyudasTest < ApplicationSystemTestCase
  setup do
    @tema_ayuda = tema_ayudas(:one)
  end

  test "visiting the index" do
    visit tema_ayudas_url
    assert_selector "h1", text: "Tema Ayudas"
  end

  test "creating a Tema ayuda" do
    visit tema_ayudas_url
    click_on "New Tema Ayuda"

    fill_in "Detalle", with: @tema_ayuda.detalle
    fill_in "Orden", with: @tema_ayuda.orden
    fill_in "Tema ayuda", with: @tema_ayuda.tema_ayuda
    fill_in "Tipo", with: @tema_ayuda.tipo
    click_on "Create Tema ayuda"

    assert_text "Tema ayuda was successfully created"
    click_on "Back"
  end

  test "updating a Tema ayuda" do
    visit tema_ayudas_url
    click_on "Edit", match: :first

    fill_in "Detalle", with: @tema_ayuda.detalle
    fill_in "Orden", with: @tema_ayuda.orden
    fill_in "Tema ayuda", with: @tema_ayuda.tema_ayuda
    fill_in "Tipo", with: @tema_ayuda.tipo
    click_on "Update Tema ayuda"

    assert_text "Tema ayuda was successfully updated"
    click_on "Back"
  end

  test "destroying a Tema ayuda" do
    visit tema_ayudas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tema ayuda was successfully destroyed"
  end
end
