require 'test_helper'

class IndSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_set = ind_sets(:one)
  end

  test "should get index" do
    get ind_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_set_url
    assert_response :success
  end

  test "should create ind_set" do
    assert_difference('IndSet.count') do
      post ind_sets_url, params: { ind_set: { ind_set: @ind_set.ind_set, set: @ind_set.set, tipo: @ind_set.tipo } }
    end

    assert_redirected_to ind_set_url(IndSet.last)
  end

  test "should show ind_set" do
    get ind_set_url(@ind_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_set_url(@ind_set)
    assert_response :success
  end

  test "should update ind_set" do
    patch ind_set_url(@ind_set), params: { ind_set: { ind_set: @ind_set.ind_set, set: @ind_set.set, tipo: @ind_set.tipo } }
    assert_redirected_to ind_set_url(@ind_set)
  end

  test "should destroy ind_set" do
    assert_difference('IndSet.count', -1) do
      delete ind_set_url(@ind_set)
    end

    assert_redirected_to ind_sets_url
  end
end
