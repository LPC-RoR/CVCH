require "application_system_test_case"

class VistasTest < ApplicationSystemTestCase
  setup do
    @vista = vistas(:one)
  end

  test "visiting the index" do
    visit vistas_url
    assert_selector "h1", text: "Vistas"
  end

  test "creating a Vista" do
    visit vistas_url
    click_on "New Vista"

    click_on "Create Vista"

    assert_text "Vista was successfully created"
    click_on "Back"
  end

  test "updating a Vista" do
    visit vistas_url
    click_on "Edit", match: :first

    click_on "Update Vista"

    assert_text "Vista was successfully updated"
    click_on "Back"
  end

  test "destroying a Vista" do
    visit vistas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vista was successfully destroyed"
  end
end
