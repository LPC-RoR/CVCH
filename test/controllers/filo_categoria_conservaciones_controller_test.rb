require 'test_helper'

class FiloCategoriaConservacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_categoria_conservacion = filo_categoria_conservaciones(:one)
  end

  test "should get index" do
    get filo_categoria_conservaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_categoria_conservacion_url
    assert_response :success
  end

  test "should create filo_categoria_conservacion" do
    assert_difference('FiloCategoriaConservacion.count') do
      post filo_categoria_conservaciones_url, params: { filo_categoria_conservacion: { codigo: @filo_categoria_conservacion.codigo, filo_categoria_conservacion: @filo_categoria_conservacion.filo_categoria_conservacion } }
    end

    assert_redirected_to filo_categoria_conservacion_url(FiloCategoriaConservacion.last)
  end

  test "should show filo_categoria_conservacion" do
    get filo_categoria_conservacion_url(@filo_categoria_conservacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_categoria_conservacion_url(@filo_categoria_conservacion)
    assert_response :success
  end

  test "should update filo_categoria_conservacion" do
    patch filo_categoria_conservacion_url(@filo_categoria_conservacion), params: { filo_categoria_conservacion: { codigo: @filo_categoria_conservacion.codigo, filo_categoria_conservacion: @filo_categoria_conservacion.filo_categoria_conservacion } }
    assert_redirected_to filo_categoria_conservacion_url(@filo_categoria_conservacion)
  end

  test "should destroy filo_categoria_conservacion" do
    assert_difference('FiloCategoriaConservacion.count', -1) do
      delete filo_categoria_conservacion_url(@filo_categoria_conservacion)
    end

    assert_redirected_to filo_categoria_conservaciones_url
  end
end
