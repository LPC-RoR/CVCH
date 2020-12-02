require "application_system_test_case"

class IntegrantesTest < ApplicationSystemTestCase
  setup do
    @integrante = integrantes(:one)
  end

  test "visiting the index" do
    visit integrantes_url
    assert_selector "h1", text: "Integrantes"
  end

  test "creating a Integrante" do
    visit integrantes_url
    click_on "New Integrante"

    fill_in "Equipo", with: @integrante.equipo_id
    fill_in "Investigador", with: @integrante.investigador_id
    click_on "Create Integrante"

    assert_text "Integrante was successfully created"
    click_on "Back"
  end

  test "updating a Integrante" do
    visit integrantes_url
    click_on "Edit", match: :first

    fill_in "Equipo", with: @integrante.equipo_id
    fill_in "Investigador", with: @integrante.investigador_id
    click_on "Update Integrante"

    assert_text "Integrante was successfully updated"
    click_on "Back"
  end

  test "destroying a Integrante" do
    visit integrantes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Integrante was successfully destroyed"
  end
end
