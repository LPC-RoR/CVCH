require "application_system_test_case"

class RelacionesTest < ApplicationSystemTestCase
  setup do
    @relacion = relaciones(:one)
  end

  test "visiting the index" do
    visit relaciones_url
    assert_selector "h1", text: "Relaciones"
  end

  test "creating a Relacion" do
    visit relaciones_url
    click_on "New Relacion"

    fill_in "Child", with: @relacion.child_id
    fill_in "Parent", with: @relacion.parent_id
    click_on "Create Relacion"

    assert_text "Relacion was successfully created"
    click_on "Back"
  end

  test "updating a Relacion" do
    visit relaciones_url
    click_on "Edit", match: :first

    fill_in "Child", with: @relacion.child_id
    fill_in "Parent", with: @relacion.parent_id
    click_on "Update Relacion"

    assert_text "Relacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Relacion" do
    visit relaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Relacion was successfully destroyed"
  end
end
