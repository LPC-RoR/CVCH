require "application_system_test_case"

class AutoresTest < ApplicationSystemTestCase
  setup do
    @autor = autores(:one)
  end

  test "visiting the index" do
    visit autores_url
    assert_selector "h1", text: "Autores"
  end

  test "creating a Autor" do
    visit autores_url
    click_on "New Autor"

    fill_in "Investigador", with: @autor.investigador_id
    fill_in "Publicacion", with: @autor.publicacion_id
    click_on "Create Autor"

    assert_text "Autor was successfully created"
    click_on "Back"
  end

  test "updating a Autor" do
    visit autores_url
    click_on "Edit", match: :first

    fill_in "Investigador", with: @autor.investigador_id
    fill_in "Publicacion", with: @autor.publicacion_id
    click_on "Update Autor"

    assert_text "Autor was successfully updated"
    click_on "Back"
  end

  test "destroying a Autor" do
    visit autores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Autor was successfully destroyed"
  end
end
