require "application_system_test_case"

class IndExpPalesTest < ApplicationSystemTestCase
  setup do
    @ind_exp_pal = ind_exp_pales(:one)
  end

  test "visiting the index" do
    visit ind_exp_pales_url
    assert_selector "h1", text: "Ind Exp Pales"
  end

  test "creating a Ind exp pal" do
    visit ind_exp_pales_url
    click_on "New Ind Exp Pal"

    fill_in "Ind expresion", with: @ind_exp_pal.ind_expresion_id
    fill_in "Ind palabra", with: @ind_exp_pal.ind_palabra_id
    click_on "Create Ind exp pal"

    assert_text "Ind exp pal was successfully created"
    click_on "Back"
  end

  test "updating a Ind exp pal" do
    visit ind_exp_pales_url
    click_on "Edit", match: :first

    fill_in "Ind expresion", with: @ind_exp_pal.ind_expresion_id
    fill_in "Ind palabra", with: @ind_exp_pal.ind_palabra_id
    click_on "Update Ind exp pal"

    assert_text "Ind exp pal was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind exp pal" do
    visit ind_exp_pales_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind exp pal was successfully destroyed"
  end
end
