require "application_system_test_case"

class IndEstructurasTest < ApplicationSystemTestCase
  setup do
    @ind_estructura = ind_estructuras(:one)
  end

  test "visiting the index" do
    visit ind_estructuras_url
    assert_selector "h1", text: "Ind Estructuras"
  end

  test "creating a Ind estructura" do
    visit ind_estructuras_url
    click_on "New Ind Estructura"

    fill_in "Ind estructura", with: @ind_estructura.ind_estructura
    click_on "Create Ind estructura"

    assert_text "Ind estructura was successfully created"
    click_on "Back"
  end

  test "updating a Ind estructura" do
    visit ind_estructuras_url
    click_on "Edit", match: :first

    fill_in "Ind estructura", with: @ind_estructura.ind_estructura
    click_on "Update Ind estructura"

    assert_text "Ind estructura was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind estructura" do
    visit ind_estructuras_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind estructura was successfully destroyed"
  end
end
