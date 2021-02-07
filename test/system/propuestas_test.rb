require "application_system_test_case"

class PropuestasTest < ApplicationSystemTestCase
  setup do
    @propuesta = propuestas(:one)
  end

  test "visiting the index" do
    visit propuestas_url
    assert_selector "h1", text: "Propuestas"
  end

  test "creating a Propuesta" do
    visit propuestas_url
    click_on "New Propuesta"

    fill_in "Instancia", with: @propuesta.instancia_id
    fill_in "Publicacion", with: @propuesta.publicacion_id
    click_on "Create Propuesta"

    assert_text "Propuesta was successfully created"
    click_on "Back"
  end

  test "updating a Propuesta" do
    visit propuestas_url
    click_on "Edit", match: :first

    fill_in "Instancia", with: @propuesta.instancia_id
    fill_in "Publicacion", with: @propuesta.publicacion_id
    click_on "Update Propuesta"

    assert_text "Propuesta was successfully updated"
    click_on "Back"
  end

  test "destroying a Propuesta" do
    visit propuestas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Propuesta was successfully destroyed"
  end
end
