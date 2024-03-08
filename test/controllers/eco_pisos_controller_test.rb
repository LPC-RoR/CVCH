require 'test_helper'

class EcoPisosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @eco_piso = eco_pisos(:one)
  end

  test "should get index" do
    get eco_pisos_url
    assert_response :success
  end

  test "should get new" do
    get new_eco_piso_url
    assert_response :success
  end

  test "should create eco_piso" do
    assert_difference('EcoPiso.count') do
      post eco_pisos_url, params: { eco_piso: { eco_formacion_id: @eco_piso.eco_formacion_id, eco_piso: @eco_piso.eco_piso } }
    end

    assert_redirected_to eco_piso_url(EcoPiso.last)
  end

  test "should show eco_piso" do
    get eco_piso_url(@eco_piso)
    assert_response :success
  end

  test "should get edit" do
    get edit_eco_piso_url(@eco_piso)
    assert_response :success
  end

  test "should update eco_piso" do
    patch eco_piso_url(@eco_piso), params: { eco_piso: { eco_formacion_id: @eco_piso.eco_formacion_id, eco_piso: @eco_piso.eco_piso } }
    assert_redirected_to eco_piso_url(@eco_piso)
  end

  test "should destroy eco_piso" do
    assert_difference('EcoPiso.count', -1) do
      delete eco_piso_url(@eco_piso)
    end

    assert_redirected_to eco_pisos_url
  end
end
