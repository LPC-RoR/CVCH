require "application_system_test_case"

class RevistasTest < ApplicationSystemTestCase
  setup do
    @revista = revistas(:one)
  end

  test "visiting the index" do
    visit revistas_url
    assert_selector "h1", text: "Revistas"
  end

  test "creating a Revista" do
    visit revistas_url
    click_on "New Revista"

    fill_in "Idioma", with: @revista.idioma_id
    fill_in "Revista", with: @revista.revista
    click_on "Create Revista"

    assert_text "Revista was successfully created"
    click_on "Back"
  end

  test "updating a Revista" do
    visit revistas_url
    click_on "Edit", match: :first

    fill_in "Idioma", with: @revista.idioma_id
    fill_in "Revista", with: @revista.revista
    click_on "Update Revista"

    assert_text "Revista was successfully updated"
    click_on "Back"
  end

  test "destroying a Revista" do
    visit revistas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Revista was successfully destroyed"
  end
end
