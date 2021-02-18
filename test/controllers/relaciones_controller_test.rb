require 'test_helper'

class RelacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @relacion = relaciones(:one)
  end

  test "should get index" do
    get relaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_relacion_url
    assert_response :success
  end

  test "should create relacion" do
    assert_difference('Relacion.count') do
      post relaciones_url, params: { relacion: { child_id: @relacion.child_id, parent_id: @relacion.parent_id } }
    end

    assert_redirected_to relacion_url(Relacion.last)
  end

  test "should show relacion" do
    get relacion_url(@relacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_relacion_url(@relacion)
    assert_response :success
  end

  test "should update relacion" do
    patch relacion_url(@relacion), params: { relacion: { child_id: @relacion.child_id, parent_id: @relacion.parent_id } }
    assert_redirected_to relacion_url(@relacion)
  end

  test "should destroy relacion" do
    assert_difference('Relacion.count', -1) do
      delete relacion_url(@relacion)
    end

    assert_redirected_to relaciones_url
  end
end
