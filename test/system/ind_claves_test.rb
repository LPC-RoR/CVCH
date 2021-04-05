require "application_system_test_case"

class IndClavesTest < ApplicationSystemTestCase
  setup do
    @ind_clave = ind_claves(:one)
  end

  test "visiting the index" do
    visit ind_claves_url
    assert_selector "h1", text: "Ind Claves"
  end

  test "creating a Ind clave" do
    visit ind_claves_url
    click_on "New Ind Clave"

    fill_in "Ind clave", with: @ind_clave.ind_clave
    click_on "Create Ind clave"

    assert_text "Ind clave was successfully created"
    click_on "Back"
  end

  test "updating a Ind clave" do
    visit ind_claves_url
    click_on "Edit", match: :first

    fill_in "Ind clave", with: @ind_clave.ind_clave
    click_on "Update Ind clave"

    assert_text "Ind clave was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind clave" do
    visit ind_claves_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind clave was successfully destroyed"
  end
end
