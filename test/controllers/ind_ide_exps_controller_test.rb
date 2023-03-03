require 'test_helper'

class IndIdeExpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_ide_exp = ind_ide_exps(:one)
  end

  test "should get index" do
    get ind_ide_exps_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_ide_exp_url
    assert_response :success
  end

  test "should create ind_ide_exp" do
    assert_difference('IndIdeExp.count') do
      post ind_ide_exps_url, params: { ind_ide_exp: { ind_expresion_id: @ind_ide_exp.ind_expresion_id, ind_idea_id: @ind_ide_exp.ind_idea_id } }
    end

    assert_redirected_to ind_ide_exp_url(IndIdeExp.last)
  end

  test "should show ind_ide_exp" do
    get ind_ide_exp_url(@ind_ide_exp)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_ide_exp_url(@ind_ide_exp)
    assert_response :success
  end

  test "should update ind_ide_exp" do
    patch ind_ide_exp_url(@ind_ide_exp), params: { ind_ide_exp: { ind_expresion_id: @ind_ide_exp.ind_expresion_id, ind_idea_id: @ind_ide_exp.ind_idea_id } }
    assert_redirected_to ind_ide_exp_url(@ind_ide_exp)
  end

  test "should destroy ind_ide_exp" do
    assert_difference('IndIdeExp.count', -1) do
      delete ind_ide_exp_url(@ind_ide_exp)
    end

    assert_redirected_to ind_ide_exps_url
  end
end
