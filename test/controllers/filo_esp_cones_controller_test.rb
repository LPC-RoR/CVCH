require 'test_helper'

class FiloEspConesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_esp_con = filo_esp_cones(:one)
  end

  test "should get index" do
    get filo_esp_cones_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_esp_con_url
    assert_response :success
  end

  test "should create filo_esp_con" do
    assert_difference('FiloEspCon.count') do
      post filo_esp_cones_url, params: { filo_esp_con: { filo_categoria_conservacion_id: @filo_esp_con.filo_categoria_conservacion_id, filo_especie_id: @filo_esp_con.filo_especie_id } }
    end

    assert_redirected_to filo_esp_con_url(FiloEspCon.last)
  end

  test "should show filo_esp_con" do
    get filo_esp_con_url(@filo_esp_con)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_esp_con_url(@filo_esp_con)
    assert_response :success
  end

  test "should update filo_esp_con" do
    patch filo_esp_con_url(@filo_esp_con), params: { filo_esp_con: { filo_categoria_conservacion_id: @filo_esp_con.filo_categoria_conservacion_id, filo_especie_id: @filo_esp_con.filo_especie_id } }
    assert_redirected_to filo_esp_con_url(@filo_esp_con)
  end

  test "should destroy filo_esp_con" do
    assert_difference('FiloEspCon.count', -1) do
      delete filo_esp_con_url(@filo_esp_con)
    end

    assert_redirected_to filo_esp_cones_url
  end
end
