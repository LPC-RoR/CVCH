require "application_system_test_case"

class FiloElementosTest < ApplicationSystemTestCase
  setup do
    @filo_elemento = filo_elementos(:one)
  end

  test "visiting the index" do
    visit filo_elementos_url
    assert_selector "h1", text: "Filo Elementos"
  end

  test "creating a Filo elemento" do
    visit filo_elementos_url
    click_on "New Filo Elemento"

    fill_in "Filo elemento", with: @filo_elemento.filo_elemento
    click_on "Create Filo elemento"

    assert_text "Filo elemento was successfully created"
    click_on "Back"
  end

  test "updating a Filo elemento" do
    visit filo_elementos_url
    click_on "Edit", match: :first

    fill_in "Filo elemento", with: @filo_elemento.filo_elemento
    click_on "Update Filo elemento"

    assert_text "Filo elemento was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo elemento" do
    visit filo_elementos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo elemento was successfully destroyed"
  end
end
