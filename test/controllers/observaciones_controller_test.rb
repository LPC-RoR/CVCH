require 'test_helper'

class ObservacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @observacion = observaciones(:one)
  end

  test "should get index" do
    get observaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_observacion_url
    assert_response :success
  end

  test "should create observacion" do
    assert_difference('Observacion.count') do
      post observaciones_url, params: { observacion: { detalle: @observacion.detalle, observacion: @observacion.observacion, publicacion_id: @observacion.publicacion_id } }
    end

    assert_redirected_to observacion_url(Observacion.last)
  end

  test "should show observacion" do
    get observacion_url(@observacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_observacion_url(@observacion)
    assert_response :success
  end

  test "should update observacion" do
    patch observacion_url(@observacion), params: { observacion: { detalle: @observacion.detalle, observacion: @observacion.observacion, publicacion_id: @observacion.publicacion_id } }
    assert_redirected_to observacion_url(@observacion)
  end

  test "should destroy observacion" do
    assert_difference('Observacion.count', -1) do
      delete observacion_url(@observacion)
    end

    assert_redirected_to observaciones_url
  end
end
