require 'test_helper'

class IndModelosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_modelo = ind_modelos(:one)
  end

  test "should get index" do
    get ind_modelos_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_modelo_url
    assert_response :success
  end

  test "should create ind_modelo" do
    assert_difference('IndModelo.count') do
      post ind_modelos_url, params: { ind_modelo: { campos: @ind_modelo.campos, ind_estructura_id: @ind_modelo.ind_estructura_id, ind_modelo: @ind_modelo.ind_modelo } }
    end

    assert_redirected_to ind_modelo_url(IndModelo.last)
  end

  test "should show ind_modelo" do
    get ind_modelo_url(@ind_modelo)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_modelo_url(@ind_modelo)
    assert_response :success
  end

  test "should update ind_modelo" do
    patch ind_modelo_url(@ind_modelo), params: { ind_modelo: { campos: @ind_modelo.campos, ind_estructura_id: @ind_modelo.ind_estructura_id, ind_modelo: @ind_modelo.ind_modelo } }
    assert_redirected_to ind_modelo_url(@ind_modelo)
  end

  test "should destroy ind_modelo" do
    assert_difference('IndModelo.count', -1) do
      delete ind_modelo_url(@ind_modelo)
    end

    assert_redirected_to ind_modelos_url
  end
end
