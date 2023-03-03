require 'test_helper'

class IndExpPalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_exp_pal = ind_exp_pales(:one)
  end

  test "should get index" do
    get ind_exp_pales_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_exp_pal_url
    assert_response :success
  end

  test "should create ind_exp_pal" do
    assert_difference('IndExpPal.count') do
      post ind_exp_pales_url, params: { ind_exp_pal: { ind_expresion_id: @ind_exp_pal.ind_expresion_id, ind_palabra_id: @ind_exp_pal.ind_palabra_id } }
    end

    assert_redirected_to ind_exp_pal_url(IndExpPal.last)
  end

  test "should show ind_exp_pal" do
    get ind_exp_pal_url(@ind_exp_pal)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_exp_pal_url(@ind_exp_pal)
    assert_response :success
  end

  test "should update ind_exp_pal" do
    patch ind_exp_pal_url(@ind_exp_pal), params: { ind_exp_pal: { ind_expresion_id: @ind_exp_pal.ind_expresion_id, ind_palabra_id: @ind_exp_pal.ind_palabra_id } }
    assert_redirected_to ind_exp_pal_url(@ind_exp_pal)
  end

  test "should destroy ind_exp_pal" do
    assert_difference('IndExpPal.count', -1) do
      delete ind_exp_pal_url(@ind_exp_pal)
    end

    assert_redirected_to ind_exp_pales_url
  end
end
