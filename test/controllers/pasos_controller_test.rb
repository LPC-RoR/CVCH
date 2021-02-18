require 'test_helper'

class PasosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paso = pasos(:one)
  end

  test "should get index" do
    get pasos_url
    assert_response :success
  end

  test "should get new" do
    get new_paso_url
    assert_response :success
  end

  test "should create paso" do
    assert_difference('Paso.count') do
      post pasos_url, params: { paso: { detalle: @paso.detalle, orden: @paso.orden, paso: @paso.paso, tutorial_id: @paso.tutorial_id } }
    end

    assert_redirected_to paso_url(Paso.last)
  end

  test "should show paso" do
    get paso_url(@paso)
    assert_response :success
  end

  test "should get edit" do
    get edit_paso_url(@paso)
    assert_response :success
  end

  test "should update paso" do
    patch paso_url(@paso), params: { paso: { detalle: @paso.detalle, orden: @paso.orden, paso: @paso.paso, tutorial_id: @paso.tutorial_id } }
    assert_redirected_to paso_url(@paso)
  end

  test "should destroy paso" do
    assert_difference('Paso.count', -1) do
      delete paso_url(@paso)
    end

    assert_redirected_to pasos_url
  end
end
