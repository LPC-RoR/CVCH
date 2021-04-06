require 'test_helper'

class IndExpresionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_expresion = ind_expresiones(:one)
  end

  test "should get index" do
    get ind_expresiones_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_expresion_url
    assert_response :success
  end

  test "should create ind_expresion" do
    assert_difference('IndExpresion.count') do
      post ind_expresiones_url, params: { ind_expresion: { ind_expresion: @ind_expresion.ind_expresion } }
    end

    assert_redirected_to ind_expresion_url(IndExpresion.last)
  end

  test "should show ind_expresion" do
    get ind_expresion_url(@ind_expresion)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_expresion_url(@ind_expresion)
    assert_response :success
  end

  test "should update ind_expresion" do
    patch ind_expresion_url(@ind_expresion), params: { ind_expresion: { ind_expresion: @ind_expresion.ind_expresion } }
    assert_redirected_to ind_expresion_url(@ind_expresion)
  end

  test "should destroy ind_expresion" do
    assert_difference('IndExpresion.count', -1) do
      delete ind_expresion_url(@ind_expresion)
    end

    assert_redirected_to ind_expresiones_url
  end
end
