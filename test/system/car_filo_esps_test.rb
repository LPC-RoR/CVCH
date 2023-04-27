require "application_system_test_case"

class CarFiloEspsTest < ApplicationSystemTestCase
  setup do
    @car_filo_esp = car_filo_esps(:one)
  end

  test "visiting the index" do
    visit car_filo_esps_url
    assert_selector "h1", text: "Car Filo Esps"
  end

  test "creating a Car filo esp" do
    visit car_filo_esps_url
    click_on "New Car Filo Esp"

    fill_in "Carpeta", with: @car_filo_esp.carpeta_id
    fill_in "Filo especie", with: @car_filo_esp.filo_especie
    click_on "Create Car filo esp"

    assert_text "Car filo esp was successfully created"
    click_on "Back"
  end

  test "updating a Car filo esp" do
    visit car_filo_esps_url
    click_on "Edit", match: :first

    fill_in "Carpeta", with: @car_filo_esp.carpeta_id
    fill_in "Filo especie", with: @car_filo_esp.filo_especie
    click_on "Update Car filo esp"

    assert_text "Car filo esp was successfully updated"
    click_on "Back"
  end

  test "destroying a Car filo esp" do
    visit car_filo_esps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Car filo esp was successfully destroyed"
  end
end
