require 'test_helper'

class IndClavesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_clave = ind_claves(:one)
  end

  test "should get index" do
    get ind_claves_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_clave_url
    assert_response :success
  end

  test "should create ind_clave" do
    assert_difference('IndClave.count') do
      post ind_claves_url, params: { ind_clave: { ind_clave: @ind_clave.ind_clave } }
    end

    assert_redirected_to ind_clave_url(IndClave.last)
  end

  test "should show ind_clave" do
    get ind_clave_url(@ind_clave)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_clave_url(@ind_clave)
    assert_response :success
  end

  test "should update ind_clave" do
    patch ind_clave_url(@ind_clave), params: { ind_clave: { ind_clave: @ind_clave.ind_clave } }
    assert_redirected_to ind_clave_url(@ind_clave)
  end

  test "should destroy ind_clave" do
    assert_difference('IndClave.count', -1) do
      delete ind_clave_url(@ind_clave)
    end

    assert_redirected_to ind_claves_url
  end
end
