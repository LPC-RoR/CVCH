require "application_system_test_case"

class HLinksTest < ApplicationSystemTestCase
  setup do
    @h_link = h_links(:one)
  end

  test "visiting the index" do
    visit h_links_url
    assert_selector "h1", text: "H Links"
  end

  test "creating a H link" do
    visit h_links_url
    click_on "New H Link"

    check "Activo" if @h_link.activo
    fill_in "Link", with: @h_link.link
    fill_in "Owner class", with: @h_link.owner_class
    fill_in "Owner", with: @h_link.owner_id
    fill_in "Texto", with: @h_link.texto
    fill_in "Tipo", with: @h_link.tipo
    click_on "Create H link"

    assert_text "H link was successfully created"
    click_on "Back"
  end

  test "updating a H link" do
    visit h_links_url
    click_on "Edit", match: :first

    check "Activo" if @h_link.activo
    fill_in "Link", with: @h_link.link
    fill_in "Owner class", with: @h_link.owner_class
    fill_in "Owner", with: @h_link.owner_id
    fill_in "Texto", with: @h_link.texto
    fill_in "Tipo", with: @h_link.tipo
    click_on "Update H link"

    assert_text "H link was successfully updated"
    click_on "Back"
  end

  test "destroying a H link" do
    visit h_links_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "H link was successfully destroyed"
  end
end
