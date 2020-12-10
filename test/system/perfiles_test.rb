require "application_system_test_case"

class PerfilesTest < ApplicationSystemTestCase
  setup do
    @perfil = perfiles(:one)
  end

  test "visiting the index" do
    visit perfiles_url
    assert_selector "h1", text: "Perfiles"
  end

  test "creating a Perfil" do
    visit perfiles_url
    click_on "New Perfil"

    fill_in "Administrador", with: @perfil.administrador_id
    fill_in "Equipo", with: @perfil.equipo_id
    fill_in "Investigador", with: @perfil.investigador_id
    fill_in "Usuario", with: @perfil.usuario_id
    click_on "Create Perfil"

    assert_text "Perfil was successfully created"
    click_on "Back"
  end

  test "updating a Perfil" do
    visit perfiles_url
    click_on "Edit", match: :first

    fill_in "Administrador", with: @perfil.administrador_id
    fill_in "Equipo", with: @perfil.equipo_id
    fill_in "Investigador", with: @perfil.investigador_id
    fill_in "Usuario", with: @perfil.usuario_id
    click_on "Update Perfil"

    assert_text "Perfil was successfully updated"
    click_on "Back"
  end

  test "destroying a Perfil" do
    visit perfiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Perfil was successfully destroyed"
  end
end
