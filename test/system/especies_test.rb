require "application_system_test_case"

class EspeciesTest < ApplicationSystemTestCase
  setup do
    @especie = especies(:one)
  end

  test "visiting the index" do
    visit especies_url
    assert_selector "h1", text: "Especies"
  end

  test "creating a Especie" do
    visit especies_url
    click_on "New Especie"

    fill_in "Especie", with: @especie.especie
    click_on "Create Especie"

    assert_text "Especie was successfully created"
    click_on "Back"
  end

  test "updating a Especie" do
    visit especies_url
    click_on "Edit", match: :first

    fill_in "Especie", with: @especie.especie
    click_on "Update Especie"

    assert_text "Especie was successfully updated"
    click_on "Back"
  end

  test "destroying a Especie" do
    visit especies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Especie was successfully destroyed"
  end
end
