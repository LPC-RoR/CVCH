require "application_system_test_case"

class IndIdeExpsTest < ApplicationSystemTestCase
  setup do
    @ind_ide_exp = ind_ide_exps(:one)
  end

  test "visiting the index" do
    visit ind_ide_exps_url
    assert_selector "h1", text: "Ind Ide Exps"
  end

  test "creating a Ind ide exp" do
    visit ind_ide_exps_url
    click_on "New Ind Ide Exp"

    fill_in "Ind expresion", with: @ind_ide_exp.ind_expresion_id
    fill_in "Ind idea", with: @ind_ide_exp.ind_idea_id
    click_on "Create Ind ide exp"

    assert_text "Ind ide exp was successfully created"
    click_on "Back"
  end

  test "updating a Ind ide exp" do
    visit ind_ide_exps_url
    click_on "Edit", match: :first

    fill_in "Ind expresion", with: @ind_ide_exp.ind_expresion_id
    fill_in "Ind idea", with: @ind_ide_exp.ind_idea_id
    click_on "Update Ind ide exp"

    assert_text "Ind ide exp was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind ide exp" do
    visit ind_ide_exps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind ide exp was successfully destroyed"
  end
end
