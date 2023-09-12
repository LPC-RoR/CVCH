require "application_system_test_case"

class FiloSinonimosTest < ApplicationSystemTestCase
  setup do
    @filo_sinonimo = filo_sinonimos(:one)
  end

  test "visiting the index" do
    visit filo_sinonimos_url
    assert_selector "h1", text: "Filo Sinonimos"
  end

  test "creating a Filo sinonimo" do
    visit filo_sinonimos_url
    click_on "New Filo Sinonimo"

    fill_in "Filo especie", with: @filo_sinonimo.filo_especie_id
    fill_in "Filo sinonimo", with: @filo_sinonimo.filo_sinonimo
    fill_in "Tipo", with: @filo_sinonimo.tipo
    click_on "Create Filo sinonimo"

    assert_text "Filo sinonimo was successfully created"
    click_on "Back"
  end

  test "updating a Filo sinonimo" do
    visit filo_sinonimos_url
    click_on "Edit", match: :first

    fill_in "Filo especie", with: @filo_sinonimo.filo_especie_id
    fill_in "Filo sinonimo", with: @filo_sinonimo.filo_sinonimo
    fill_in "Tipo", with: @filo_sinonimo.tipo
    click_on "Update Filo sinonimo"

    assert_text "Filo sinonimo was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo sinonimo" do
    visit filo_sinonimos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo sinonimo was successfully destroyed"
  end
end
