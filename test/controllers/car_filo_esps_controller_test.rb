require 'test_helper'

class CarFiloEspsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car_filo_esp = car_filo_esps(:one)
  end

  test "should get index" do
    get car_filo_esps_url
    assert_response :success
  end

  test "should get new" do
    get new_car_filo_esp_url
    assert_response :success
  end

  test "should create car_filo_esp" do
    assert_difference('CarFiloEsp.count') do
      post car_filo_esps_url, params: { car_filo_esp: { carpeta_id: @car_filo_esp.carpeta_id, filo_especie: @car_filo_esp.filo_especie } }
    end

    assert_redirected_to car_filo_esp_url(CarFiloEsp.last)
  end

  test "should show car_filo_esp" do
    get car_filo_esp_url(@car_filo_esp)
    assert_response :success
  end

  test "should get edit" do
    get edit_car_filo_esp_url(@car_filo_esp)
    assert_response :success
  end

  test "should update car_filo_esp" do
    patch car_filo_esp_url(@car_filo_esp), params: { car_filo_esp: { carpeta_id: @car_filo_esp.carpeta_id, filo_especie: @car_filo_esp.filo_especie } }
    assert_redirected_to car_filo_esp_url(@car_filo_esp)
  end

  test "should destroy car_filo_esp" do
    assert_difference('CarFiloEsp.count', -1) do
      delete car_filo_esp_url(@car_filo_esp)
    end

    assert_redirected_to car_filo_esps_url
  end
end
