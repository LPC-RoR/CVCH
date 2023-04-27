require 'test_helper'

class FiloEspEspSinonimosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_esp_esp_sinonimo = filo_esp_esp_sinonimos(:one)
  end

  test "should get index" do
    get filo_esp_esp_sinonimos_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_esp_esp_sinonimo_url
    assert_response :success
  end

  test "should create filo_esp_esp_sinonimo" do
    assert_difference('FiloEspEspSinonimo.count') do
      post filo_esp_esp_sinonimos_url, params: { filo_esp_esp_sinonimo: { especie_id: @filo_esp_esp_sinonimo.especie_id, sinonimo_id: @filo_esp_esp_sinonimo.sinonimo_id } }
    end

    assert_redirected_to filo_esp_esp_sinonimo_url(FiloEspEspSinonimo.last)
  end

  test "should show filo_esp_esp_sinonimo" do
    get filo_esp_esp_sinonimo_url(@filo_esp_esp_sinonimo)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_esp_esp_sinonimo_url(@filo_esp_esp_sinonimo)
    assert_response :success
  end

  test "should update filo_esp_esp_sinonimo" do
    patch filo_esp_esp_sinonimo_url(@filo_esp_esp_sinonimo), params: { filo_esp_esp_sinonimo: { especie_id: @filo_esp_esp_sinonimo.especie_id, sinonimo_id: @filo_esp_esp_sinonimo.sinonimo_id } }
    assert_redirected_to filo_esp_esp_sinonimo_url(@filo_esp_esp_sinonimo)
  end

  test "should destroy filo_esp_esp_sinonimo" do
    assert_difference('FiloEspEspSinonimo.count', -1) do
      delete filo_esp_esp_sinonimo_url(@filo_esp_esp_sinonimo)
    end

    assert_redirected_to filo_esp_esp_sinonimos_url
  end
end
