require "application_system_test_case"

class IndModelosTest < ApplicationSystemTestCase
  setup do
    @ind_modelo = ind_modelos(:one)
  end

  test "visiting the index" do
    visit ind_modelos_url
    assert_selector "h1", text: "Ind Modelos"
  end

  test "creating a Ind modelo" do
    visit ind_modelos_url
    click_on "New Ind Modelo"

    fill_in "Campos", with: @ind_modelo.campos
    fill_in "Ind estructura", with: @ind_modelo.ind_estructura_id
    fill_in "Ind modelo", with: @ind_modelo.ind_modelo
    click_on "Create Ind modelo"

    assert_text "Ind modelo was successfully created"
    click_on "Back"
  end

  test "updating a Ind modelo" do
    visit ind_modelos_url
    click_on "Edit", match: :first

    fill_in "Campos", with: @ind_modelo.campos
    fill_in "Ind estructura", with: @ind_modelo.ind_estructura_id
    fill_in "Ind modelo", with: @ind_modelo.ind_modelo
    click_on "Update Ind modelo"

    assert_text "Ind modelo was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind modelo" do
    visit ind_modelos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind modelo was successfully destroyed"
  end
end
