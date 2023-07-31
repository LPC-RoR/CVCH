require "application_system_test_case"

class FiloConflictosTest < ApplicationSystemTestCase
  setup do
    @filo_conflicto = filo_conflictos(:one)
  end

  test "visiting the index" do
    visit filo_conflictos_url
    assert_selector "h1", text: "Filo Conflictos"
  end

  test "creating a Filo conflicto" do
    visit filo_conflictos_url
    click_on "New Filo Conflicto"

    fill_in "App perfil", with: @filo_conflicto.app_perfil_id
    fill_in "Detalle", with: @filo_conflicto.detalle
    fill_in "Filo conflicto", with: @filo_conflicto.filo_conflicto
    check "Resuelto" if @filo_conflicto.resuelto
    click_on "Create Filo conflicto"

    assert_text "Filo conflicto was successfully created"
    click_on "Back"
  end

  test "updating a Filo conflicto" do
    visit filo_conflictos_url
    click_on "Edit", match: :first

    fill_in "App perfil", with: @filo_conflicto.app_perfil_id
    fill_in "Detalle", with: @filo_conflicto.detalle
    fill_in "Filo conflicto", with: @filo_conflicto.filo_conflicto
    check "Resuelto" if @filo_conflicto.resuelto
    click_on "Update Filo conflicto"

    assert_text "Filo conflicto was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo conflicto" do
    visit filo_conflictos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo conflicto was successfully destroyed"
  end
end
