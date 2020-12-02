require "application_system_test_case"

class RevisionesTest < ApplicationSystemTestCase
  setup do
    @revision = revisiones(:one)
  end

  test "visiting the index" do
    visit revisiones_url
    assert_selector "h1", text: "Revisiones"
  end

  test "creating a Revision" do
    visit revisiones_url
    click_on "New Revision"

    click_on "Create Revision"

    assert_text "Revision was successfully created"
    click_on "Back"
  end

  test "updating a Revision" do
    visit revisiones_url
    click_on "Edit", match: :first

    click_on "Update Revision"

    assert_text "Revision was successfully updated"
    click_on "Back"
  end

  test "destroying a Revision" do
    visit revisiones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Revision was successfully destroyed"
  end
end
