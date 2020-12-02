require "application_system_test_case"

class InvestigadoresTest < ApplicationSystemTestCase
  setup do
    @investigador = investigadores(:one)
  end

  test "visiting the index" do
    visit investigadores_url
    assert_selector "h1", text: "Investigadores"
  end

  test "creating a Investigador" do
    visit investigadores_url
    click_on "New Investigador"

    fill_in "Departamento", with: @investigador.departamento_id
    fill_in "Email", with: @investigador.email
    fill_in "Investigador", with: @investigador.investigador
    fill_in "Orcid", with: @investigador.orcid
    click_on "Create Investigador"

    assert_text "Investigador was successfully created"
    click_on "Back"
  end

  test "updating a Investigador" do
    visit investigadores_url
    click_on "Edit", match: :first

    fill_in "Departamento", with: @investigador.departamento_id
    fill_in "Email", with: @investigador.email
    fill_in "Investigador", with: @investigador.investigador
    fill_in "Orcid", with: @investigador.orcid
    click_on "Update Investigador"

    assert_text "Investigador was successfully updated"
    click_on "Back"
  end

  test "destroying a Investigador" do
    visit investigadores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Investigador was successfully destroyed"
  end
end
