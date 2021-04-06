require "application_system_test_case"

class IndRedaccionesTest < ApplicationSystemTestCase
  setup do
    @ind_redaccion = ind_redacciones(:one)
  end

  test "visiting the index" do
    visit ind_redacciones_url
    assert_selector "h1", text: "Ind Redacciones"
  end

  test "creating a Ind redaccion" do
    visit ind_redacciones_url
    click_on "New Ind Redaccion"

    fill_in "Ind expresion", with: @ind_redaccion.ind_expresion_id
    fill_in "Ind palabra", with: @ind_redaccion.ind_palabra_id
    click_on "Create Ind redaccion"

    assert_text "Ind redaccion was successfully created"
    click_on "Back"
  end

  test "updating a Ind redaccion" do
    visit ind_redacciones_url
    click_on "Edit", match: :first

    fill_in "Ind expresion", with: @ind_redaccion.ind_expresion_id
    fill_in "Ind palabra", with: @ind_redaccion.ind_palabra_id
    click_on "Update Ind redaccion"

    assert_text "Ind redaccion was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind redaccion" do
    visit ind_redacciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind redaccion was successfully destroyed"
  end
end
