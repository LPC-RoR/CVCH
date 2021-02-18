require "application_system_test_case"

class MejorasTest < ApplicationSystemTestCase
  setup do
    @mejora = mejoras(:one)
  end

  test "visiting the index" do
    visit mejoras_url
    assert_selector "h1", text: "Mejoras"
  end

  test "creating a Mejora" do
    visit mejoras_url
    click_on "New Mejora"

    fill_in "Detalle", with: @mejora.detalle
    fill_in "Mejora", with: @mejora.mejora
    fill_in "Publicacion", with: @mejora.publicacion_id
    click_on "Create Mejora"

    assert_text "Mejora was successfully created"
    click_on "Back"
  end

  test "updating a Mejora" do
    visit mejoras_url
    click_on "Edit", match: :first

    fill_in "Detalle", with: @mejora.detalle
    fill_in "Mejora", with: @mejora.mejora
    fill_in "Publicacion", with: @mejora.publicacion_id
    click_on "Update Mejora"

    assert_text "Mejora was successfully updated"
    click_on "Back"
  end

  test "destroying a Mejora" do
    visit mejoras_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mejora was successfully destroyed"
  end
end
