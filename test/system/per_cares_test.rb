require "application_system_test_case"

class PerCaresTest < ApplicationSystemTestCase
  setup do
    @per_car = per_cares(:one)
  end

  test "visiting the index" do
    visit per_cares_url
    assert_selector "h1", text: "Per Cares"
  end

  test "creating a Per car" do
    visit per_cares_url
    click_on "New Per Car"

    fill_in "App perfil", with: @per_car.app_perfil_id
    fill_in "Carpeta", with: @per_car.carpeta_id
    click_on "Create Per car"

    assert_text "Per car was successfully created"
    click_on "Back"
  end

  test "updating a Per car" do
    visit per_cares_url
    click_on "Edit", match: :first

    fill_in "App perfil", with: @per_car.app_perfil_id
    fill_in "Carpeta", with: @per_car.carpeta_id
    click_on "Update Per car"

    assert_text "Per car was successfully updated"
    click_on "Back"
  end

  test "destroying a Per car" do
    visit per_cares_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Per car was successfully destroyed"
  end
end
