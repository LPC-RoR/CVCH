require "application_system_test_case"

class FiloDefInteraccionesTest < ApplicationSystemTestCase
  setup do
    @filo_def_interaccion = filo_def_interacciones(:one)
  end

  test "visiting the index" do
    visit filo_def_interacciones_url
    assert_selector "h1", text: "Filo Def Interacciones"
  end

  test "creating a Filo def interaccion" do
    visit filo_def_interacciones_url
    click_on "New Filo Def Interaccion"

    fill_in "Filo def interaccion", with: @filo_def_interaccion.filo_def_interaccion
    click_on "Create Filo def interaccion"

    assert_text "Filo def interaccion was successfully created"
    click_on "Back"
  end

  test "updating a Filo def interaccion" do
    visit filo_def_interacciones_url
    click_on "Edit", match: :first

    fill_in "Filo def interaccion", with: @filo_def_interaccion.filo_def_interaccion
    click_on "Update Filo def interaccion"

    assert_text "Filo def interaccion was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo def interaccion" do
    visit filo_def_interacciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo def interaccion was successfully destroyed"
  end
end
