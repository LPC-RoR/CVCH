require "application_system_test_case"

class PasosTest < ApplicationSystemTestCase
  setup do
    @paso = pasos(:one)
  end

  test "visiting the index" do
    visit pasos_url
    assert_selector "h1", text: "Pasos"
  end

  test "creating a Paso" do
    visit pasos_url
    click_on "New Paso"

    fill_in "Detalle", with: @paso.detalle
    fill_in "Orden", with: @paso.orden
    fill_in "Paso", with: @paso.paso
    fill_in "Tutorial", with: @paso.tutorial_id
    click_on "Create Paso"

    assert_text "Paso was successfully created"
    click_on "Back"
  end

  test "updating a Paso" do
    visit pasos_url
    click_on "Edit", match: :first

    fill_in "Detalle", with: @paso.detalle
    fill_in "Orden", with: @paso.orden
    fill_in "Paso", with: @paso.paso
    fill_in "Tutorial", with: @paso.tutorial_id
    click_on "Update Paso"

    assert_text "Paso was successfully updated"
    click_on "Back"
  end

  test "destroying a Paso" do
    visit pasos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Paso was successfully destroyed"
  end
end
