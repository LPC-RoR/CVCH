require 'test_helper'

class RutasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ruta = rutas(:one)
  end

  test "should get index" do
    get rutas_url
    assert_response :success
  end

  test "should get new" do
    get new_ruta_url
    assert_response :success
  end

  test "should create ruta" do
    assert_difference('Ruta.count') do
      post rutas_url, params: { ruta: { instancia_id: @ruta.instancia_id, publicacion_id: @ruta.publicacion_id } }
    end

    assert_redirected_to ruta_url(Ruta.last)
  end

  test "should show ruta" do
    get ruta_url(@ruta)
    assert_response :success
  end

  test "should get edit" do
    get edit_ruta_url(@ruta)
    assert_response :success
  end

  test "should update ruta" do
    patch ruta_url(@ruta), params: { ruta: { instancia_id: @ruta.instancia_id, publicacion_id: @ruta.publicacion_id } }
    assert_redirected_to ruta_url(@ruta)
  end

  test "should destroy ruta" do
    assert_difference('Ruta.count', -1) do
      delete ruta_url(@ruta)
    end

    assert_redirected_to rutas_url
  end
end
