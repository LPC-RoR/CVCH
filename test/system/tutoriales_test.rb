require "application_system_test_case"

class TutorialesTest < ApplicationSystemTestCase
  setup do
    @tutorial = tutoriales(:one)
  end

  test "visiting the index" do
    visit tutoriales_url
    assert_selector "h1", text: "Tutoriales"
  end

  test "creating a Tutorial" do
    visit tutoriales_url
    click_on "New Tutorial"

    fill_in "Detalle", with: @tutorial.detalle
    fill_in "Orden", with: @tutorial.orden
    fill_in "Tema ayuda", with: @tutorial.tema_ayuda_id
    fill_in "Tutorial", with: @tutorial.tutorial
    click_on "Create Tutorial"

    assert_text "Tutorial was successfully created"
    click_on "Back"
  end

  test "updating a Tutorial" do
    visit tutoriales_url
    click_on "Edit", match: :first

    fill_in "Detalle", with: @tutorial.detalle
    fill_in "Orden", with: @tutorial.orden
    fill_in "Tema ayuda", with: @tutorial.tema_ayuda_id
    fill_in "Tutorial", with: @tutorial.tutorial
    click_on "Update Tutorial"

    assert_text "Tutorial was successfully updated"
    click_on "Back"
  end

  test "destroying a Tutorial" do
    visit tutoriales_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tutorial was successfully destroyed"
  end
end
