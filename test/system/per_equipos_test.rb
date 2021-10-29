require "application_system_test_case"

class PerEquiposTest < ApplicationSystemTestCase
  setup do
    @per_equipo = per_equipos(:one)
  end

  test "visiting the index" do
    visit per_equipos_url
    assert_selector "h1", text: "Per Equipos"
  end

  test "creating a Per equipo" do
    visit per_equipos_url
    click_on "New Per Equipo"

    fill_in "App perfil", with: @per_equipo.app_perfil_id
    fill_in "Equipo", with: @per_equipo.equipo_id
    click_on "Create Per equipo"

    assert_text "Per equipo was successfully created"
    click_on "Back"
  end

  test "updating a Per equipo" do
    visit per_equipos_url
    click_on "Edit", match: :first

    fill_in "App perfil", with: @per_equipo.app_perfil_id
    fill_in "Equipo", with: @per_equipo.equipo_id
    click_on "Update Per equipo"

    assert_text "Per equipo was successfully updated"
    click_on "Back"
  end

  test "destroying a Per equipo" do
    visit per_equipos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Per equipo was successfully destroyed"
  end
end
