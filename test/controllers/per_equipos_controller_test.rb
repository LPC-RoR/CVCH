require 'test_helper'

class PerEquiposControllerTest < ActionDispatch::IntegrationTest
  setup do
    @per_equipo = per_equipos(:one)
  end

  test "should get index" do
    get per_equipos_url
    assert_response :success
  end

  test "should get new" do
    get new_per_equipo_url
    assert_response :success
  end

  test "should create per_equipo" do
    assert_difference('PerEquipo.count') do
      post per_equipos_url, params: { per_equipo: { app_perfil_id: @per_equipo.app_perfil_id, equipo_id: @per_equipo.equipo_id } }
    end

    assert_redirected_to per_equipo_url(PerEquipo.last)
  end

  test "should show per_equipo" do
    get per_equipo_url(@per_equipo)
    assert_response :success
  end

  test "should get edit" do
    get edit_per_equipo_url(@per_equipo)
    assert_response :success
  end

  test "should update per_equipo" do
    patch per_equipo_url(@per_equipo), params: { per_equipo: { app_perfil_id: @per_equipo.app_perfil_id, equipo_id: @per_equipo.equipo_id } }
    assert_redirected_to per_equipo_url(@per_equipo)
  end

  test "should destroy per_equipo" do
    assert_difference('PerEquipo.count', -1) do
      delete per_equipo_url(@per_equipo)
    end

    assert_redirected_to per_equipos_url
  end
end
