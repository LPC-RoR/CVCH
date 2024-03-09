require 'test_helper'

class EcoSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @eco_set = eco_sets(:one)
  end

  test "should get index" do
    get eco_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_eco_set_url
    assert_response :success
  end

  test "should create eco_set" do
    assert_difference('EcoSet.count') do
      post eco_sets_url, params: { eco_set: { annio: @eco_set.annio, coordenadas: @eco_set.coordenadas, eco_lugar_id: @eco_set.eco_lugar_id, publicacion_id: @eco_set.publicacion_id } }
    end

    assert_redirected_to eco_set_url(EcoSet.last)
  end

  test "should show eco_set" do
    get eco_set_url(@eco_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_eco_set_url(@eco_set)
    assert_response :success
  end

  test "should update eco_set" do
    patch eco_set_url(@eco_set), params: { eco_set: { annio: @eco_set.annio, coordenadas: @eco_set.coordenadas, eco_lugar_id: @eco_set.eco_lugar_id, publicacion_id: @eco_set.publicacion_id } }
    assert_redirected_to eco_set_url(@eco_set)
  end

  test "should destroy eco_set" do
    assert_difference('EcoSet.count', -1) do
      delete eco_set_url(@eco_set)
    end

    assert_redirected_to eco_sets_url
  end
end
