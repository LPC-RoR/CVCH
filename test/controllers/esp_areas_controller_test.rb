require 'test_helper'

class EspAreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @esp_area = esp_areas(:one)
  end

  test "should get index" do
    get esp_areas_url
    assert_response :success
  end

  test "should get new" do
    get new_esp_area_url
    assert_response :success
  end

  test "should create esp_area" do
    assert_difference('EspArea.count') do
      post esp_areas_url, params: { esp_area: { area_id: @esp_area.area_id, especie_id: @esp_area.especie_id } }
    end

    assert_redirected_to esp_area_url(EspArea.last)
  end

  test "should show esp_area" do
    get esp_area_url(@esp_area)
    assert_response :success
  end

  test "should get edit" do
    get edit_esp_area_url(@esp_area)
    assert_response :success
  end

  test "should update esp_area" do
    patch esp_area_url(@esp_area), params: { esp_area: { area_id: @esp_area.area_id, especie_id: @esp_area.especie_id } }
    assert_redirected_to esp_area_url(@esp_area)
  end

  test "should destroy esp_area" do
    assert_difference('EspArea.count', -1) do
      delete esp_area_url(@esp_area)
    end

    assert_redirected_to esp_areas_url
  end
end
