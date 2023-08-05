require 'test_helper'

class FiloEspTiposControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_esp_tipo = filo_esp_tipos(:one)
  end

  test "should get index" do
    get filo_esp_tipos_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_esp_tipo_url
    assert_response :success
  end

  test "should create filo_esp_tipo" do
    assert_difference('FiloEspTipo.count') do
      post filo_esp_tipos_url, params: { filo_esp_tipo: { filo_especie_id: @filo_esp_tipo.filo_especie_id, filo_tipo_especie_id: @filo_esp_tipo.filo_tipo_especie_id } }
    end

    assert_redirected_to filo_esp_tipo_url(FiloEspTipo.last)
  end

  test "should show filo_esp_tipo" do
    get filo_esp_tipo_url(@filo_esp_tipo)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_esp_tipo_url(@filo_esp_tipo)
    assert_response :success
  end

  test "should update filo_esp_tipo" do
    patch filo_esp_tipo_url(@filo_esp_tipo), params: { filo_esp_tipo: { filo_especie_id: @filo_esp_tipo.filo_especie_id, filo_tipo_especie_id: @filo_esp_tipo.filo_tipo_especie_id } }
    assert_redirected_to filo_esp_tipo_url(@filo_esp_tipo)
  end

  test "should destroy filo_esp_tipo" do
    assert_difference('FiloEspTipo.count', -1) do
      delete filo_esp_tipo_url(@filo_esp_tipo)
    end

    assert_redirected_to filo_esp_tipos_url
  end
end
