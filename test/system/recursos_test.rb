require "application_system_test_case"

class RecursosTest < ApplicationSystemTestCase
  setup do
    @recurso = recursos(:one)
  end

  test "visiting the index" do
    visit recursos_url
    assert_selector "h1", text: "Recursos"
  end

  test "creating a Recurso" do
    visit recursos_url
    click_on "New Recurso"

    click_on "Create Recurso"

    assert_text "Recurso was successfully created"
    click_on "Back"
  end

  test "updating a Recurso" do
    visit recursos_url
    click_on "Edit", match: :first

    click_on "Update Recurso"

    assert_text "Recurso was successfully updated"
    click_on "Back"
  end

  test "destroying a Recurso" do
    visit recursos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recurso was successfully destroyed"
  end
end
