require 'test_helper'

class IndSinonimosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_sinonimo = ind_sinonimos(:one)
  end

  test "should get index" do
    get ind_sinonimos_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_sinonimo_url
    assert_response :success
  end

  test "should create ind_sinonimo" do
    assert_difference('IndSinonimo.count') do
      post ind_sinonimos_url, params: { ind_sinonimo: { ind_sinonimo: @ind_sinonimo.ind_sinonimo } }
    end

    assert_redirected_to ind_sinonimo_url(IndSinonimo.last)
  end

  test "should show ind_sinonimo" do
    get ind_sinonimo_url(@ind_sinonimo)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_sinonimo_url(@ind_sinonimo)
    assert_response :success
  end

  test "should update ind_sinonimo" do
    patch ind_sinonimo_url(@ind_sinonimo), params: { ind_sinonimo: { ind_sinonimo: @ind_sinonimo.ind_sinonimo } }
    assert_redirected_to ind_sinonimo_url(@ind_sinonimo)
  end

  test "should destroy ind_sinonimo" do
    assert_difference('IndSinonimo.count', -1) do
      delete ind_sinonimo_url(@ind_sinonimo)
    end

    assert_redirected_to ind_sinonimos_url
  end
end
