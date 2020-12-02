require 'test_helper'

class CarpetasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @carpeta = carpetas(:one)
  end

  test "should get index" do
    get carpetas_url
    assert_response :success
  end

  test "should get new" do
    get new_carpeta_url
    assert_response :success
  end

  test "should create carpeta" do
    assert_difference('Carpeta.count') do
      post carpetas_url, params: { carpeta: { carpeta: @carpeta.carpeta, equipo_id: @carpeta.equipo_id, investigador_id: @carpeta.investigador_id } }
    end

    assert_redirected_to carpeta_url(Carpeta.last)
  end

  test "should show carpeta" do
    get carpeta_url(@carpeta)
    assert_response :success
  end

  test "should get edit" do
    get edit_carpeta_url(@carpeta)
    assert_response :success
  end

  test "should update carpeta" do
    patch carpeta_url(@carpeta), params: { carpeta: { carpeta: @carpeta.carpeta, equipo_id: @carpeta.equipo_id, investigador_id: @carpeta.investigador_id } }
    assert_redirected_to carpeta_url(@carpeta)
  end

  test "should destroy carpeta" do
    assert_difference('Carpeta.count', -1) do
      delete carpeta_url(@carpeta)
    end

    assert_redirected_to carpetas_url
  end
end
