require 'test_helper'

class IndBasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_base = ind_bases(:one)
  end

  test "should get index" do
    get ind_bases_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_base_url
    assert_response :success
  end

  test "should create ind_base" do
    assert_difference('IndBase.count') do
      post ind_bases_url, params: { ind_base: { clave_id: @ind_base.clave_id, ind_palabra_id: @ind_base.ind_palabra_id } }
    end

    assert_redirected_to ind_base_url(IndBase.last)
  end

  test "should show ind_base" do
    get ind_base_url(@ind_base)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_base_url(@ind_base)
    assert_response :success
  end

  test "should update ind_base" do
    patch ind_base_url(@ind_base), params: { ind_base: { clave_id: @ind_base.clave_id, ind_palabra_id: @ind_base.ind_palabra_id } }
    assert_redirected_to ind_base_url(@ind_base)
  end

  test "should destroy ind_base" do
    assert_difference('IndBase.count', -1) do
      delete ind_base_url(@ind_base)
    end

    assert_redirected_to ind_bases_url
  end
end
