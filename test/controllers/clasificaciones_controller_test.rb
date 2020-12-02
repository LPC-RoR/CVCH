require 'test_helper'

class ClasificacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @clasificacion = clasificaciones(:one)
  end

  test "should get index" do
    get clasificaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_clasificacion_url
    assert_response :success
  end

  test "should create clasificacion" do
    assert_difference('Clasificacion.count') do
      post clasificaciones_url, params: { clasificacion: { carpeta_id: @clasificacion.carpeta_id, publicacion_id: @clasificacion.publicacion_id } }
    end

    assert_redirected_to clasificacion_url(Clasificacion.last)
  end

  test "should show clasificacion" do
    get clasificacion_url(@clasificacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_clasificacion_url(@clasificacion)
    assert_response :success
  end

  test "should update clasificacion" do
    patch clasificacion_url(@clasificacion), params: { clasificacion: { carpeta_id: @clasificacion.carpeta_id, publicacion_id: @clasificacion.publicacion_id } }
    assert_redirected_to clasificacion_url(@clasificacion)
  end

  test "should destroy clasificacion" do
    assert_difference('Clasificacion.count', -1) do
      delete clasificacion_url(@clasificacion)
    end

    assert_redirected_to clasificaciones_url
  end
end
