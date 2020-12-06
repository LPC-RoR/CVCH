require "application_system_test_case"

class ConceptosTest < ApplicationSystemTestCase
  setup do
    @concepto = conceptos(:one)
  end

  test "visiting the index" do
    visit conceptos_url
    assert_selector "h1", text: "Conceptos"
  end

  test "creating a Concepto" do
    visit conceptos_url
    click_on "New Concepto"

    fill_in "Concepto", with: @concepto.concepto
    click_on "Create Concepto"

    assert_text "Concepto was successfully created"
    click_on "Back"
  end

  test "updating a Concepto" do
    visit conceptos_url
    click_on "Edit", match: :first

    fill_in "Concepto", with: @concepto.concepto
    click_on "Update Concepto"

    assert_text "Concepto was successfully updated"
    click_on "Back"
  end

  test "destroying a Concepto" do
    visit conceptos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Concepto was successfully destroyed"
  end
end
