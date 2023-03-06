require 'test_helper'

class FiloEspeciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_especie = filo_especies(:one)
  end

  test "should get index" do
    get filo_especies_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_especie_url
    assert_response :success
  end

  test "should create filo_especie" do
    assert_difference('FiloEspecie.count') do
      post filo_especies_url, params: { filo_especie: { filo_especie: @filo_especie.filo_especie, iucn: @filo_especie.iucn, nombre_comun: @filo_especie.nombre_comun } }
    end

    assert_redirected_to filo_especie_url(FiloEspecie.last)
  end

  test "should show filo_especie" do
    get filo_especie_url(@filo_especie)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_especie_url(@filo_especie)
    assert_response :success
  end

  test "should update filo_especie" do
    patch filo_especie_url(@filo_especie), params: { filo_especie: { filo_especie: @filo_especie.filo_especie, iucn: @filo_especie.iucn, nombre_comun: @filo_especie.nombre_comun } }
    assert_redirected_to filo_especie_url(@filo_especie)
  end

  test "should destroy filo_especie" do
    assert_difference('FiloEspecie.count', -1) do
      delete filo_especie_url(@filo_especie)
    end

    assert_redirected_to filo_especies_url
  end
end
