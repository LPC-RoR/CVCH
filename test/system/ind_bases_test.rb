require "application_system_test_case"

class IndBasesTest < ApplicationSystemTestCase
  setup do
    @ind_base = ind_bases(:one)
  end

  test "visiting the index" do
    visit ind_bases_url
    assert_selector "h1", text: "Ind Bases"
  end

  test "creating a Ind base" do
    visit ind_bases_url
    click_on "New Ind Base"

    fill_in "Clave", with: @ind_base.clave_id
    fill_in "Ind palabra", with: @ind_base.ind_palabra_id
    click_on "Create Ind base"

    assert_text "Ind base was successfully created"
    click_on "Back"
  end

  test "updating a Ind base" do
    visit ind_bases_url
    click_on "Edit", match: :first

    fill_in "Clave", with: @ind_base.clave_id
    fill_in "Ind palabra", with: @ind_base.ind_palabra_id
    click_on "Update Ind base"

    assert_text "Ind base was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind base" do
    visit ind_bases_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind base was successfully destroyed"
  end
end
