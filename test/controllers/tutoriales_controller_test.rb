require 'test_helper'

class TutorialesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tutorial = tutoriales(:one)
  end

  test "should get index" do
    get tutoriales_url
    assert_response :success
  end

  test "should get new" do
    get new_tutorial_url
    assert_response :success
  end

  test "should create tutorial" do
    assert_difference('Tutorial.count') do
      post tutoriales_url, params: { tutorial: { detalle: @tutorial.detalle, orden: @tutorial.orden, tema_ayuda_id: @tutorial.tema_ayuda_id, tutorial: @tutorial.tutorial } }
    end

    assert_redirected_to tutorial_url(Tutorial.last)
  end

  test "should show tutorial" do
    get tutorial_url(@tutorial)
    assert_response :success
  end

  test "should get edit" do
    get edit_tutorial_url(@tutorial)
    assert_response :success
  end

  test "should update tutorial" do
    patch tutorial_url(@tutorial), params: { tutorial: { detalle: @tutorial.detalle, orden: @tutorial.orden, tema_ayuda_id: @tutorial.tema_ayuda_id, tutorial: @tutorial.tutorial } }
    assert_redirected_to tutorial_url(@tutorial)
  end

  test "should destroy tutorial" do
    assert_difference('Tutorial.count', -1) do
      delete tutorial_url(@tutorial)
    end

    assert_redirected_to tutoriales_url
  end
end
