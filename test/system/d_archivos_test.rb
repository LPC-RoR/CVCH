require "application_system_test_case"

class DArchivosTest < ApplicationSystemTestCase
  setup do
    @d_archivo = d_archivos(:one)
  end

  test "visiting the index" do
    visit d_archivos_url
    assert_selector "h1", text: "D archivos"
  end

  test "should create d archivo" do
    visit d_archivos_url
    click_on "New d archivo"

    fill_in "Archivo", with: @d_archivo.archivo
    click_on "Create D archivo"

    assert_text "D archivo was successfully created"
    click_on "Back"
  end

  test "should update D archivo" do
    visit d_archivo_url(@d_archivo)
    click_on "Edit this d archivo", match: :first

    fill_in "Archivo", with: @d_archivo.archivo
    click_on "Update D archivo"

    assert_text "D archivo was successfully updated"
    click_on "Back"
  end

  test "should destroy D archivo" do
    visit d_archivo_url(@d_archivo)
    click_on "Destroy this d archivo", match: :first

    assert_text "D archivo was successfully destroyed"
  end
end
