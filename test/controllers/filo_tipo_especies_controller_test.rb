require 'test_helper'

class FiloTipoEspeciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_tipo_especie = filo_tipo_especies(:one)
  end

  test "should get index" do
    get filo_tipo_especies_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_tipo_especie_url
    assert_response :success
  end

  test "should create filo_tipo_especie" do
    assert_difference('FiloTipoEspecie.count') do
      post filo_tipo_especies_url, params: { filo_tipo_especie: { filo_tipo_especie: @filo_tipo_especie.filo_tipo_especie } }
    end

    assert_redirected_to filo_tipo_especie_url(FiloTipoEspecie.last)
  end

  test "should show filo_tipo_especie" do
    get filo_tipo_especie_url(@filo_tipo_especie)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_tipo_especie_url(@filo_tipo_especie)
    assert_response :success
  end

  test "should update filo_tipo_especie" do
    patch filo_tipo_especie_url(@filo_tipo_especie), params: { filo_tipo_especie: { filo_tipo_especie: @filo_tipo_especie.filo_tipo_especie } }
    assert_redirected_to filo_tipo_especie_url(@filo_tipo_especie)
  end

  test "should destroy filo_tipo_especie" do
    assert_difference('FiloTipoEspecie.count', -1) do
      delete filo_tipo_especie_url(@filo_tipo_especie)
    end

    assert_redirected_to filo_tipo_especies_url
  end
end
