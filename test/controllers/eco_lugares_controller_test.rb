require 'test_helper'

class EcoLugaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @eco_lugar = eco_lugares(:one)
  end

  test "should get index" do
    get eco_lugares_url
    assert_response :success
  end

  test "should get new" do
    get new_eco_lugar_url
    assert_response :success
  end

  test "should create eco_lugar" do
    assert_difference('EcoLugar.count') do
      post eco_lugares_url, params: { eco_lugar: { coordenadas: @eco_lugar.coordenadas, eco_lugar: @eco_lugar.eco_lugar, region_id: @eco_lugar.region_id } }
    end

    assert_redirected_to eco_lugar_url(EcoLugar.last)
  end

  test "should show eco_lugar" do
    get eco_lugar_url(@eco_lugar)
    assert_response :success
  end

  test "should get edit" do
    get edit_eco_lugar_url(@eco_lugar)
    assert_response :success
  end

  test "should update eco_lugar" do
    patch eco_lugar_url(@eco_lugar), params: { eco_lugar: { coordenadas: @eco_lugar.coordenadas, eco_lugar: @eco_lugar.eco_lugar, region_id: @eco_lugar.region_id } }
    assert_redirected_to eco_lugar_url(@eco_lugar)
  end

  test "should destroy eco_lugar" do
    assert_difference('EcoLugar.count', -1) do
      delete eco_lugar_url(@eco_lugar)
    end

    assert_redirected_to eco_lugares_url
  end
end
