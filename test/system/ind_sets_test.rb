require "application_system_test_case"

class IndSetsTest < ApplicationSystemTestCase
  setup do
    @ind_set = ind_sets(:one)
  end

  test "visiting the index" do
    visit ind_sets_url
    assert_selector "h1", text: "Ind Sets"
  end

  test "creating a Ind set" do
    visit ind_sets_url
    click_on "New Ind Set"

    fill_in "Ind set", with: @ind_set.ind_set
    fill_in "Set", with: @ind_set.set
    fill_in "Tipo", with: @ind_set.tipo
    click_on "Create Ind set"

    assert_text "Ind set was successfully created"
    click_on "Back"
  end

  test "updating a Ind set" do
    visit ind_sets_url
    click_on "Edit", match: :first

    fill_in "Ind set", with: @ind_set.ind_set
    fill_in "Set", with: @ind_set.set
    fill_in "Tipo", with: @ind_set.tipo
    click_on "Update Ind set"

    assert_text "Ind set was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind set" do
    visit ind_sets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind set was successfully destroyed"
  end
end
