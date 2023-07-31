require "application_system_test_case"

class FiloConfElemsTest < ApplicationSystemTestCase
  setup do
    @filo_conf_elem = filo_conf_elems(:one)
  end

  test "visiting the index" do
    visit filo_conf_elems_url
    assert_selector "h1", text: "Filo Conf Elems"
  end

  test "creating a Filo conf elem" do
    visit filo_conf_elems_url
    click_on "New Filo Conf Elem"

    fill_in "Filo conflicto", with: @filo_conf_elem.filo_conflicto_id
    fill_in "Filo elem class", with: @filo_conf_elem.filo_elem_class
    fill_in "Filo elem", with: @filo_conf_elem.filo_elem_id
    click_on "Create Filo conf elem"

    assert_text "Filo conf elem was successfully created"
    click_on "Back"
  end

  test "updating a Filo conf elem" do
    visit filo_conf_elems_url
    click_on "Edit", match: :first

    fill_in "Filo conflicto", with: @filo_conf_elem.filo_conflicto_id
    fill_in "Filo elem class", with: @filo_conf_elem.filo_elem_class
    fill_in "Filo elem", with: @filo_conf_elem.filo_elem_id
    click_on "Update Filo conf elem"

    assert_text "Filo conf elem was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo conf elem" do
    visit filo_conf_elems_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo conf elem was successfully destroyed"
  end
end
