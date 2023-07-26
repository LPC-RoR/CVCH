require "application_system_test_case"

class FiloFEspRegsTest < ApplicationSystemTestCase
  setup do
    @filo_f_esp_reg = filo_f_esp_regs(:one)
  end

  test "visiting the index" do
    visit filo_f_esp_regs_url
    assert_selector "h1", text: "Filo F Esp Regs"
  end

  test "creating a Filo f esp reg" do
    visit filo_f_esp_regs_url
    click_on "New Filo F Esp Reg"

    fill_in "Filo especie", with: @filo_f_esp_reg.filo_especie_id
    fill_in "Region", with: @filo_f_esp_reg.region_id
    click_on "Create Filo f esp reg"

    assert_text "Filo f esp reg was successfully created"
    click_on "Back"
  end

  test "updating a Filo f esp reg" do
    visit filo_f_esp_regs_url
    click_on "Edit", match: :first

    fill_in "Filo especie", with: @filo_f_esp_reg.filo_especie_id
    fill_in "Region", with: @filo_f_esp_reg.region_id
    click_on "Update Filo f esp reg"

    assert_text "Filo f esp reg was successfully updated"
    click_on "Back"
  end

  test "destroying a Filo f esp reg" do
    visit filo_f_esp_regs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filo f esp reg was successfully destroyed"
  end
end
