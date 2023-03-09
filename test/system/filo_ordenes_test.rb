require "application_system_test_case"

class FiloOrdenesTest < ApplicationSystemTestCase
  setup do
    @filo_orden = filo_ordenes(:one)
  end

  test "visiting the index" do
    visit filo_ordenes_url
    assert_selector "h1", text: "Filo Ordenes"
  end

  test "creating a Filo orden" do
    visit filo_ordenes_url
    click_on "New Filo Orden"

    fill_in "Filo orden", with: @filo_orden.filo_orden
    fill_in "Orden", with: @filo_orden.orden
    click_on "Create Filo orden"

    assert_text "Filo orden was successfully created"
    click_on "Back"
  end

  test "updating a Filo orden" do
    visit filo_ordenes_url
    click_on "Edit", match: :first

    fill_in "Filo orden", with: @filo_orden.filo_orden
    fill_in "Orden", with: @filo_orden.orden
    click_on "Update Filo orden"

    assert_text "Filo orden was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo orden" do
    visit filo_ordenes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo orden was successfully destroyed"
  end
end
