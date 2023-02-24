require "application_system_test_case"

class FiloEleElesTest < ApplicationSystemTestCase
  setup do
    @filo_ele_el = filo_ele_eles(:one)
  end

  test "visiting the index" do
    visit filo_ele_eles_url
    assert_selector "h1", text: "Filo Ele Eles"
  end

  test "creating a Filo ele ele" do
    visit filo_ele_eles_url
    click_on "New Filo Ele Ele"

    fill_in "Child", with: @filo_ele_el.child_id
    fill_in "Parent", with: @filo_ele_el.parent_id
    click_on "Create Filo ele ele"

    assert_text "Filo ele ele was successfully created"
    click_on "Back"
  end

  test "updating a Filo ele ele" do
    visit filo_ele_eles_url
    click_on "Edit", match: :first

    fill_in "Child", with: @filo_ele_el.child_id
    fill_in "Parent", with: @filo_ele_el.parent_id
    click_on "Update Filo ele ele"

    assert_text "Filo ele ele was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo ele ele" do
    visit filo_ele_eles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo ele ele was successfully destroyed"
  end
end
