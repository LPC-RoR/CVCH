require 'test_helper'

class FiloActualizacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_actualizacion = filo_actualizaciones(:one)
  end

  test "should get index" do
    get filo_actualizaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_actualizacion_url
    assert_response :success
  end

  test "should create filo_actualizacion" do
    assert_difference('FiloActualizacion.count') do
      post filo_actualizaciones_url, params: { filo_actualizacion: { app_perfil_id: @filo_actualizacion.app_perfil_id, filo_fuente_id: @filo_actualizacion.filo_fuente_id, link_fuentesinonimia: @filo_actualizacion.link_fuentesinonimia, nombre_comun: @filo_actualizacion.nombre_comun, referencia: @filo_actualizacion.referencia } }
    end

    assert_redirected_to filo_actualizacion_url(FiloActualizacion.last)
  end

  test "should show filo_actualizacion" do
    get filo_actualizacion_url(@filo_actualizacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_actualizacion_url(@filo_actualizacion)
    assert_response :success
  end

  test "should update filo_actualizacion" do
    patch filo_actualizacion_url(@filo_actualizacion), params: { filo_actualizacion: { app_perfil_id: @filo_actualizacion.app_perfil_id, filo_fuente_id: @filo_actualizacion.filo_fuente_id, link_fuentesinonimia: @filo_actualizacion.link_fuentesinonimia, nombre_comun: @filo_actualizacion.nombre_comun, referencia: @filo_actualizacion.referencia } }
    assert_redirected_to filo_actualizacion_url(@filo_actualizacion)
  end

  test "should destroy filo_actualizacion" do
    assert_difference('FiloActualizacion.count', -1) do
      delete filo_actualizacion_url(@filo_actualizacion)
    end

    assert_redirected_to filo_actualizaciones_url
  end
end
