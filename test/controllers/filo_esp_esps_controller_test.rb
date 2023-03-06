require 'test_helper'

class FiloEspEspsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_esp_esp = filo_esp_esps(:one)
  end

  test "should get index" do
    get filo_esp_esps_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_esp_esp_url
    assert_response :success
  end

  test "should create filo_esp_esp" do
    assert_difference('FiloEspEsp.count') do
      post filo_esp_esps_url, params: { filo_esp_esp: { child_id: @filo_esp_esp.child_id, parent_id: @filo_esp_esp.parent_id } }
    end

    assert_redirected_to filo_esp_esp_url(FiloEspEsp.last)
  end

  test "should show filo_esp_esp" do
    get filo_esp_esp_url(@filo_esp_esp)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_esp_esp_url(@filo_esp_esp)
    assert_response :success
  end

  test "should update filo_esp_esp" do
    patch filo_esp_esp_url(@filo_esp_esp), params: { filo_esp_esp: { child_id: @filo_esp_esp.child_id, parent_id: @filo_esp_esp.parent_id } }
    assert_redirected_to filo_esp_esp_url(@filo_esp_esp)
  end

  test "should destroy filo_esp_esp" do
    assert_difference('FiloEspEsp.count', -1) do
      delete filo_esp_esp_url(@filo_esp_esp)
    end

    assert_redirected_to filo_esp_esps_url
  end
end
