require "application_system_test_case"

class IndDireccionesTest < ApplicationSystemTestCase
  setup do
    @ind_direccion = ind_direcciones(:one)
  end

  test "visiting the index" do
    visit ind_direcciones_url
    assert_selector "h1", text: "Ind Direcciones"
  end

  test "creating a Ind direccion" do
    visit ind_direcciones_url
    click_on "New Ind Direccion"

    fill_in "Destino", with: @ind_direccion.destino_id
    fill_in "Origen", with: @ind_direccion.origen_id
    click_on "Create Ind direccion"

    assert_text "Ind direccion was successfully created"
    click_on "Back"
  end

  test "updating a Ind direccion" do
    visit ind_direcciones_url
    click_on "Edit", match: :first

    fill_in "Destino", with: @ind_direccion.destino_id
    fill_in "Origen", with: @ind_direccion.origen_id
    click_on "Update Ind direccion"

    assert_text "Ind direccion was successfully updated"
    click_on "Back"
  end

  test "destroying a Ind direccion" do
    visit ind_direcciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ind direccion was successfully destroyed"
  end
end
