require "application_system_test_case"

class FiloCategoriaConservacionesTest < ApplicationSystemTestCase
  setup do
    @filo_categoria_conservacion = filo_categoria_conservaciones(:one)
  end

  test "visiting the index" do
    visit filo_categoria_conservaciones_url
    assert_selector "h1", text: "Filo Categoria Conservaciones"
  end

  test "creating a Filo categoria conservacion" do
    visit filo_categoria_conservaciones_url
    click_on "New Filo Categoria Conservacion"

    fill_in "Codigo", with: @filo_categoria_conservacion.codigo
    fill_in "Filo categoria conservacion", with: @filo_categoria_conservacion.filo_categoria_conservacion
    click_on "Create Filo categoria conservacion"

    assert_text "Filo categoria conservacion was successfully created"
    click_on "Back"
  end

  test "updating a Filo categoria conservacion" do
    visit filo_categoria_conservaciones_url
    click_on "Edit", match: :first

    fill_in "Codigo", with: @filo_categoria_conservacion.codigo
    fill_in "Filo categoria conservacion", with: @filo_categoria_conservacion.filo_categoria_conservacion
    click_on "Update Filo categoria conservacion"

    assert_text "Filo categoria conservacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo categoria conservacion" do
    visit filo_categoria_conservaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo categoria conservacion was successfully destroyed"
  end
end
