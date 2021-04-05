require "application_system_test_case"

class IndIndicesTest < ApplicationSystemTestCase
  setup do
    @ind_indice = ind_indices(:one)
  end

  test "visiting the index" do
    visit ind_indices_url
    assert_selector "h1", text: "Ind Indices"
  end

  test "creating a Ind indice" do
    visit ind_indices_url
    click_on "New Ind Indice"

    fill_in "Class name", with: @ind_indice.class_name
    fill_in "Ind clave", with: @ind_indice.ind_clave_id
    fill_in "Objeto", with: @ind_indice.objeto_id
    click_on "Create Ind indice"

    assert_text "Ind indice was successfully created"
    click_on "Back"
  end

  test "updating a Ind indice" do
    visit ind_indices_url
    click_on "Edit", match: :first

    fill_in "Class name", with: @ind_indice.class_name
    fill_in "Ind clave", with: @ind_indice.ind_clave_id
    fill_in "Objeto", with: @ind_indice.objeto_id
    click_on "Update Ind indice"

    assert_text "Ind indice was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind indice" do
    visit ind_indices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind indice was successfully destroyed"
  end
end
