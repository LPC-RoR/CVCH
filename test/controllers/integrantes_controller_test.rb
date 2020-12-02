require 'test_helper'

class IntegrantesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @integrante = integrantes(:one)
  end

  test "should get index" do
    get integrantes_url
    assert_response :success
  end

  test "should get new" do
    get new_integrante_url
    assert_response :success
  end

  test "should create integrante" do
    assert_difference('Integrante.count') do
      post integrantes_url, params: { integrante: { equipo_id: @integrante.equipo_id, investigador_id: @integrante.investigador_id } }
    end

    assert_redirected_to integrante_url(Integrante.last)
  end

  test "should show integrante" do
    get integrante_url(@integrante)
    assert_response :success
  end

  test "should get edit" do
    get edit_integrante_url(@integrante)
    assert_response :success
  end

  test "should update integrante" do
    patch integrante_url(@integrante), params: { integrante: { equipo_id: @integrante.equipo_id, investigador_id: @integrante.investigador_id } }
    assert_redirected_to integrante_url(@integrante)
  end

  test "should destroy integrante" do
    assert_difference('Integrante.count', -1) do
      delete integrante_url(@integrante)
    end

    assert_redirected_to integrantes_url
  end
end
