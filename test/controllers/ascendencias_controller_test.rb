require 'test_helper'

class AscendenciasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ascendencia = ascendencias(:one)
  end

  test "should get index" do
    get ascendencias_url
    assert_response :success
  end

  test "should get new" do
    get new_ascendencia_url
    assert_response :success
  end

  test "should create ascendencia" do
    assert_difference('Ascendencia.count') do
      post ascendencias_url, params: { ascendencia: { hijo_id: @ascendencia.hijo_id, padre_id: @ascendencia.padre_id } }
    end

    assert_redirected_to ascendencia_url(Ascendencia.last)
  end

  test "should show ascendencia" do
    get ascendencia_url(@ascendencia)
    assert_response :success
  end

  test "should get edit" do
    get edit_ascendencia_url(@ascendencia)
    assert_response :success
  end

  test "should update ascendencia" do
    patch ascendencia_url(@ascendencia), params: { ascendencia: { hijo_id: @ascendencia.hijo_id, padre_id: @ascendencia.padre_id } }
    assert_redirected_to ascendencia_url(@ascendencia)
  end

  test "should destroy ascendencia" do
    assert_difference('Ascendencia.count', -1) do
      delete ascendencia_url(@ascendencia)
    end

    assert_redirected_to ascendencias_url
  end
end
