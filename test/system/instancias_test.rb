require "application_system_test_case"

class InstanciasTest < ApplicationSystemTestCase
  setup do
    @instancia = instancias(:one)
  end

  test "visiting the index" do
    visit instancias_url
    assert_selector "h1", text: "Instancias"
  end

  test "creating a Instancia" do
    visit instancias_url
    click_on "New Instancia"

    fill_in "Concepto", with: @instancia.concepto_id
    fill_in "Instancia", with: @instancia.instancia
    fill_in "Sha1", with: @instancia.sha1
    click_on "Create Instancia"

    assert_text "Instancia was successfully created"
    click_on "Back"
  end

  test "updating a Instancia" do
    visit instancias_url
    click_on "Edit", match: :first

    fill_in "Concepto", with: @instancia.concepto_id
    fill_in "Instancia", with: @instancia.instancia
    fill_in "Sha1", with: @instancia.sha1
    click_on "Update Instancia"

    assert_text "Instancia was successfully updated"
    click_on "Back"
  end

  test "destroying a Instancia" do
    visit instancias_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Instancia was successfully destroyed"
  end
end
