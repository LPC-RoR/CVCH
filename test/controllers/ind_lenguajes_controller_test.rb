require 'test_helper'

class IndLenguajesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_lenguaje = ind_lenguajes(:one)
  end

  test "should get index" do
    get ind_lenguajes_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_lenguaje_url
    assert_response :success
  end

  test "should create ind_lenguaje" do
    assert_difference('IndLenguaje.count') do
      post ind_lenguajes_url, params: { ind_lenguaje: { ind_lenguaje: @ind_lenguaje.ind_lenguaje } }
    end

    assert_redirected_to ind_lenguaje_url(IndLenguaje.last)
  end

  test "should show ind_lenguaje" do
    get ind_lenguaje_url(@ind_lenguaje)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_lenguaje_url(@ind_lenguaje)
    assert_response :success
  end

  test "should update ind_lenguaje" do
    patch ind_lenguaje_url(@ind_lenguaje), params: { ind_lenguaje: { ind_lenguaje: @ind_lenguaje.ind_lenguaje } }
    assert_redirected_to ind_lenguaje_url(@ind_lenguaje)
  end

  test "should destroy ind_lenguaje" do
    assert_difference('IndLenguaje.count', -1) do
      delete ind_lenguaje_url(@ind_lenguaje)
    end

    assert_redirected_to ind_lenguajes_url
  end
end
