require 'test_helper'

class FiloEspSinosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_esp_sino = filo_esp_sinos(:one)
  end

  test "should get index" do
    get filo_esp_sinos_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_esp_sino_url
    assert_response :success
  end

  test "should create filo_esp_sino" do
    assert_difference('FiloEspSino.count') do
      post filo_esp_sinos_url, params: { filo_esp_sino: { filo_especie_id: @filo_esp_sino.filo_especie_id, filo_sinonimo_id: @filo_esp_sino.filo_sinonimo_id } }
    end

    assert_redirected_to filo_esp_sino_url(FiloEspSino.last)
  end

  test "should show filo_esp_sino" do
    get filo_esp_sino_url(@filo_esp_sino)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_esp_sino_url(@filo_esp_sino)
    assert_response :success
  end

  test "should update filo_esp_sino" do
    patch filo_esp_sino_url(@filo_esp_sino), params: { filo_esp_sino: { filo_especie_id: @filo_esp_sino.filo_especie_id, filo_sinonimo_id: @filo_esp_sino.filo_sinonimo_id } }
    assert_redirected_to filo_esp_sino_url(@filo_esp_sino)
  end

  test "should destroy filo_esp_sino" do
    assert_difference('FiloEspSino.count', -1) do
      delete filo_esp_sino_url(@filo_esp_sino)
    end

    assert_redirected_to filo_esp_sinos_url
  end
end
