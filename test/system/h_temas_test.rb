require "application_system_test_case"

class HTemasTest < ApplicationSystemTestCase
  setup do
    @h_tema = h_temas(:one)
  end

  test "visiting the index" do
    visit h_temas_url
    assert_selector "h1", text: "H Temas"
  end

  test "creating a H tema" do
    visit h_temas_url
    click_on "New H Tema"

    check "Activo" if @h_tema.activo
    fill_in "Credito imagen", with: @h_tema.credito_imagen
    fill_in "Detalle", with: @h_tema.detalle
    fill_in "Imagen", with: @h_tema.imagen
    fill_in "Orden", with: @h_tema.orden
    fill_in "Tema", with: @h_tema.tema
    click_on "Create H tema"

    assert_text "H tema was successfully created"
    click_on "Back"
  end

  test "updating a H tema" do
    visit h_temas_url
    click_on "Edit", match: :first

    check "Activo" if @h_tema.activo
    fill_in "Credito imagen", with: @h_tema.credito_imagen
    fill_in "Detalle", with: @h_tema.detalle
    fill_in "Imagen", with: @h_tema.imagen
    fill_in "Orden", with: @h_tema.orden
    fill_in "Tema", with: @h_tema.tema
    click_on "Update H tema"

    assert_text "H tema was successfully updated"
    click_on "Back"
  end

  test "destroying a H tema" do
    visit h_temas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "H tema was successfully destroyed"
  end
end
