require 'test_helper'

class FiloFEspRegsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_f_esp_reg = filo_f_esp_regs(:one)
  end

  test "should get index" do
    get filo_f_esp_regs_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_f_esp_reg_url
    assert_response :success
  end

  test "should create filo_f_esp_reg" do
    assert_difference('FiloFEspReg.count') do
      post filo_f_esp_regs_url, params: { filo_f_esp_reg: { filo_especie_id: @filo_f_esp_reg.filo_especie_id, region_id: @filo_f_esp_reg.region_id } }
    end

    assert_redirected_to filo_f_esp_reg_url(FiloFEspReg.last)
  end

  test "should show filo_f_esp_reg" do
    get filo_f_esp_reg_url(@filo_f_esp_reg)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_f_esp_reg_url(@filo_f_esp_reg)
    assert_response :success
  end

  test "should update filo_f_esp_reg" do
    patch filo_f_esp_reg_url(@filo_f_esp_reg), params: { filo_f_esp_reg: { filo_especie_id: @filo_f_esp_reg.filo_especie_id, region_id: @filo_f_esp_reg.region_id } }
    assert_redirected_to filo_f_esp_reg_url(@filo_f_esp_reg)
  end

  test "should destroy filo_f_esp_reg" do
    assert_difference('FiloFEspReg.count', -1) do
      delete filo_f_esp_reg_url(@filo_f_esp_reg)
    end

    assert_redirected_to filo_f_esp_regs_url
  end
end
