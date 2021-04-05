require "application_system_test_case"

class IndLenguajesTest < ApplicationSystemTestCase
  setup do
    @ind_lenguaje = ind_lenguajes(:one)
  end

  test "visiting the index" do
    visit ind_lenguajes_url
    assert_selector "h1", text: "Ind Lenguajes"
  end

  test "creating a Ind lenguaje" do
    visit ind_lenguajes_url
    click_on "New Ind Lenguaje"

    fill_in "Ind lenguaje", with: @ind_lenguaje.ind_lenguaje
    click_on "Create Ind lenguaje"

    assert_text "Ind lenguaje was successfully created"
    click_on "Back"
  end

  test "updating a Ind lenguaje" do
    visit ind_lenguajes_url
    click_on "Edit", match: :first

    fill_in "Ind lenguaje", with: @ind_lenguaje.ind_lenguaje
    click_on "Update Ind lenguaje"

    assert_text "Ind lenguaje was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind lenguaje" do
    visit ind_lenguajes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind lenguaje was successfully destroyed"
  end
end
