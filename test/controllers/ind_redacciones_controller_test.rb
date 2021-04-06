require 'test_helper'

class IndRedaccionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_redaccion = ind_redacciones(:one)
  end

  test "should get index" do
    get ind_redacciones_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_redaccion_url
    assert_response :success
  end

  test "should create ind_redaccion" do
    assert_difference('IndRedaccion.count') do
      post ind_redacciones_url, params: { ind_redaccion: { ind_expresion_id: @ind_redaccion.ind_expresion_id, ind_palabra_id: @ind_redaccion.ind_palabra_id } }
    end

    assert_redirected_to ind_redaccion_url(IndRedaccion.last)
  end

  test "should show ind_redaccion" do
    get ind_redaccion_url(@ind_redaccion)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_redaccion_url(@ind_redaccion)
    assert_response :success
  end

  test "should update ind_redaccion" do
    patch ind_redaccion_url(@ind_redaccion), params: { ind_redaccion: { ind_expresion_id: @ind_redaccion.ind_expresion_id, ind_palabra_id: @ind_redaccion.ind_palabra_id } }
    assert_redirected_to ind_redaccion_url(@ind_redaccion)
  end

  test "should destroy ind_redaccion" do
    assert_difference('IndRedaccion.count', -1) do
      delete ind_redaccion_url(@ind_redaccion)
    end

    assert_redirected_to ind_redacciones_url
  end
end
