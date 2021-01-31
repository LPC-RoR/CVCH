require 'test_helper'

class HerenciasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @herencia = herencias(:one)
  end

  test "should get index" do
    get herencias_url
    assert_response :success
  end

  test "should get new" do
    get new_herencia_url
    assert_response :success
  end

  test "should create herencia" do
    assert_difference('Herencia.count') do
      post herencias_url, params: { herencia: { carpeta_id: @herencia.carpeta_id, equipo_id: @herencia.equipo_id } }
    end

    assert_redirected_to herencia_url(Herencia.last)
  end

  test "should show herencia" do
    get herencia_url(@herencia)
    assert_response :success
  end

  test "should get edit" do
    get edit_herencia_url(@herencia)
    assert_response :success
  end

  test "should update herencia" do
    patch herencia_url(@herencia), params: { herencia: { carpeta_id: @herencia.carpeta_id, equipo_id: @herencia.equipo_id } }
    assert_redirected_to herencia_url(@herencia)
  end

  test "should destroy herencia" do
    assert_difference('Herencia.count', -1) do
      delete herencia_url(@herencia)
    end

    assert_redirected_to herencias_url
  end
end
