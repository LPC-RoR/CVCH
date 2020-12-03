require 'test_helper'

class VistasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vista = vistas(:one)
  end

  test "should get index" do
    get vistas_url
    assert_response :success
  end

  test "should get new" do
    get new_vista_url
    assert_response :success
  end

  test "should create vista" do
    assert_difference('Vista.count') do
      post vistas_url, params: { vista: {  } }
    end

    assert_redirected_to vista_url(Vista.last)
  end

  test "should show vista" do
    get vista_url(@vista)
    assert_response :success
  end

  test "should get edit" do
    get edit_vista_url(@vista)
    assert_response :success
  end

  test "should update vista" do
    patch vista_url(@vista), params: { vista: {  } }
    assert_redirected_to vista_url(@vista)
  end

  test "should destroy vista" do
    assert_difference('Vista.count', -1) do
      delete vista_url(@vista)
    end

    assert_redirected_to vistas_url
  end
end
