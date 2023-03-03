require "application_system_test_case"

class IndIdeasTest < ApplicationSystemTestCase
  setup do
    @ind_idea = ind_ideas(:one)
  end

  test "visiting the index" do
    visit ind_ideas_url
    assert_selector "h1", text: "Ind Ideas"
  end

  test "creating a Ind idea" do
    visit ind_ideas_url
    click_on "New Ind Idea"

    fill_in "Ind estructura", with: @ind_idea.ind_estructura_id
    fill_in "Ind idea", with: @ind_idea.ind_idea
    click_on "Create Ind idea"

    assert_text "Ind idea was successfully created"
    click_on "Back"
  end

  test "updating a Ind idea" do
    visit ind_ideas_url
    click_on "Edit", match: :first

    fill_in "Ind estructura", with: @ind_idea.ind_estructura_id
    fill_in "Ind idea", with: @ind_idea.ind_idea
    click_on "Update Ind idea"

    assert_text "Ind idea was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind idea" do
    visit ind_ideas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind idea was successfully destroyed"
  end
end
