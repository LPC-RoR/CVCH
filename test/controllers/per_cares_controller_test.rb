require 'test_helper'

class PerCaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @per_car = per_cares(:one)
  end

  test "should get index" do
    get per_cares_url
    assert_response :success
  end

  test "should get new" do
    get new_per_car_url
    assert_response :success
  end

  test "should create per_car" do
    assert_difference('PerCar.count') do
      post per_cares_url, params: { per_car: { app_perfil_id: @per_car.app_perfil_id, carpeta_id: @per_car.carpeta_id } }
    end

    assert_redirected_to per_car_url(PerCar.last)
  end

  test "should show per_car" do
    get per_car_url(@per_car)
    assert_response :success
  end

  test "should get edit" do
    get edit_per_car_url(@per_car)
    assert_response :success
  end

  test "should update per_car" do
    patch per_car_url(@per_car), params: { per_car: { app_perfil_id: @per_car.app_perfil_id, carpeta_id: @per_car.carpeta_id } }
    assert_redirected_to per_car_url(@per_car)
  end

  test "should destroy per_car" do
    assert_difference('PerCar.count', -1) do
      delete per_car_url(@per_car)
    end

    assert_redirected_to per_cares_url
  end
end
