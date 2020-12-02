require "application_system_test_case"

class ContribucionesTest < ApplicationSystemTestCase
  setup do
    @contribucion = contribuciones(:one)
  end

  test "visiting the index" do
    visit contribuciones_url
    assert_selector "h1", text: "Contribuciones"
  end

  test "creating a Contribucion" do
    visit contribuciones_url
    click_on "New Contribucion"

    click_on "Create Contribucion"

    assert_text "Contribucion was successfully created"
    click_on "Back"
  end

  test "updating a Contribucion" do
    visit contribuciones_url
    click_on "Edit", match: :first

    click_on "Update Contribucion"

    assert_text "Contribucion was successfully updated"
    click_on "Back"
  end

  test "destroying a Contribucion" do
    visit contribuciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contribucion was successfully destroyed"
  end
end
