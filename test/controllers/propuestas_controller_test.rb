require 'test_helper'

class PropuestasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @propuesta = propuestas(:one)
  end

  test "should get index" do
    get propuestas_url
    assert_response :success
  end

  test "should get new" do
    get new_propuesta_url
    assert_response :success
  end

  test "should create propuesta" do
    assert_difference('Propuesta.count') do
      post propuestas_url, params: { propuesta: { instancia_id: @propuesta.instancia_id, publicacion_id: @propuesta.publicacion_id } }
    end

    assert_redirected_to propuesta_url(Propuesta.last)
  end

  test "should show propuesta" do
    get propuesta_url(@propuesta)
    assert_response :success
  end

  test "should get edit" do
    get edit_propuesta_url(@propuesta)
    assert_response :success
  end

  test "should update propuesta" do
    patch propuesta_url(@propuesta), params: { propuesta: { instancia_id: @propuesta.instancia_id, publicacion_id: @propuesta.publicacion_id } }
    assert_redirected_to propuesta_url(@propuesta)
  end

  test "should destroy propuesta" do
    assert_difference('Propuesta.count', -1) do
      delete propuesta_url(@propuesta)
    end

    assert_redirected_to propuestas_url
  end
end
