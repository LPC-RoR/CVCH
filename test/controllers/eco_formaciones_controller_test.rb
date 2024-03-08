require 'test_helper'

class EcoFormacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @eco_formacion = eco_formaciones(:one)
  end

  test "should get index" do
    get eco_formaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_eco_formacion_url
    assert_response :success
  end

  test "should create eco_formacion" do
    assert_difference('EcoFormacion.count') do
      post eco_formaciones_url, params: { eco_formacion: { eco_formacion: @eco_formacion.eco_formacion } }
    end

    assert_redirected_to eco_formacion_url(EcoFormacion.last)
  end

  test "should show eco_formacion" do
    get eco_formacion_url(@eco_formacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_eco_formacion_url(@eco_formacion)
    assert_response :success
  end

  test "should update eco_formacion" do
    patch eco_formacion_url(@eco_formacion), params: { eco_formacion: { eco_formacion: @eco_formacion.eco_formacion } }
    assert_redirected_to eco_formacion_url(@eco_formacion)
  end

  test "should destroy eco_formacion" do
    assert_difference('EcoFormacion.count', -1) do
      delete eco_formacion_url(@eco_formacion)
    end

    assert_redirected_to eco_formaciones_url
  end
end
