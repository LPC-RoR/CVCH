require "application_system_test_case"

class IndExpresionesTest < ApplicationSystemTestCase
  setup do
    @ind_expresion = ind_expresiones(:one)
  end

  test "visiting the index" do
    visit ind_expresiones_url
    assert_selector "h1", text: "Ind Expresiones"
  end

  test "creating a Ind expresion" do
    visit ind_expresiones_url
    click_on "New Ind Expresion"

    fill_in "Ind expresion", with: @ind_expresion.ind_expresion
    click_on "Create Ind expresion"

    assert_text "Ind expresion was successfully created"
    click_on "Back"
  end

  test "updating a Ind expresion" do
    visit ind_expresiones_url
    click_on "Edit", match: :first

    fill_in "Ind expresion", with: @ind_expresion.ind_expresion
    click_on "Update Ind expresion"

    assert_text "Ind expresion was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind expresion" do
    visit ind_expresiones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind expresion was successfully destroyed"
  end
end
