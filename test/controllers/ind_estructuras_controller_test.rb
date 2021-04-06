require 'test_helper'

class IndEstructurasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_estructura = ind_estructuras(:one)
  end

  test "should get index" do
    get ind_estructuras_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_estructura_url
    assert_response :success
  end

  test "should create ind_estructura" do
    assert_difference('IndEstructura.count') do
      post ind_estructuras_url, params: { ind_estructura: { ind_estructura: @ind_estructura.ind_estructura } }
    end

    assert_redirected_to ind_estructura_url(IndEstructura.last)
  end

  test "should show ind_estructura" do
    get ind_estructura_url(@ind_estructura)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_estructura_url(@ind_estructura)
    assert_response :success
  end

  test "should update ind_estructura" do
    patch ind_estructura_url(@ind_estructura), params: { ind_estructura: { ind_estructura: @ind_estructura.ind_estructura } }
    assert_redirected_to ind_estructura_url(@ind_estructura)
  end

  test "should destroy ind_estructura" do
    assert_difference('IndEstructura.count', -1) do
      delete ind_estructura_url(@ind_estructura)
    end

    assert_redirected_to ind_estructuras_url
  end
end
