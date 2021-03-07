require "application_system_test_case"

class EtiquetasTest < ApplicationSystemTestCase
  setup do
    @etiqueta = etiquetas(:one)
  end

  test "visiting the index" do
    visit etiquetas_url
    assert_selector "h1", text: "Etiquetas"
  end

  test "creating a Etiqueta" do
    visit etiquetas_url
    click_on "New Etiqueta"

    fill_in "Categoria", with: @etiqueta.categoria_id
    fill_in "Especie", with: @etiqueta.especie_id
    fill_in "Publicacion", with: @etiqueta.publicacion_id
    click_on "Create Etiqueta"

    assert_text "Etiqueta was successfully created"
    click_on "Back"
  end

  test "updating a Etiqueta" do
    visit etiquetas_url
    click_on "Edit", match: :first

    fill_in "Categoria", with: @etiqueta.categoria_id
    fill_in "Especie", with: @etiqueta.especie_id
    fill_in "Publicacion", with: @etiqueta.publicacion_id
    click_on "Update Etiqueta"

    assert_text "Etiqueta was successfully updated"
    click_on "Back"
  end

  test "destroying a Etiqueta" do
    visit etiquetas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Etiqueta was successfully destroyed"
  end
end
