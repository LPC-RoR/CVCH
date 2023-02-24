require "application_system_test_case"

class IndSinonimosTest < ApplicationSystemTestCase
  setup do
    @ind_sinonimo = ind_sinonimos(:one)
  end

  test "visiting the index" do
    visit ind_sinonimos_url
    assert_selector "h1", text: "Ind Sinonimos"
  end

  test "creating a Ind sinonimo" do
    visit ind_sinonimos_url
    click_on "New Ind Sinonimo"

    fill_in "Ind sinonimo", with: @ind_sinonimo.ind_sinonimo
    click_on "Create Ind sinonimo"

    assert_text "Ind sinonimo was successfully created"
    click_on "Back"
  end

  test "updating a Ind sinonimo" do
    visit ind_sinonimos_url
    click_on "Edit", match: :first

    fill_in "Ind sinonimo", with: @ind_sinonimo.ind_sinonimo
    click_on "Update Ind sinonimo"

    assert_text "Ind sinonimo was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind sinonimo" do
    visit ind_sinonimos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind sinonimo was successfully destroyed"
  end
end
