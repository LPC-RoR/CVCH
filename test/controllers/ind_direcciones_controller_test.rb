require 'test_helper'

class IndDireccionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_direccion = ind_direcciones(:one)
  end

  test "should get index" do
    get ind_direcciones_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_direccion_url
    assert_response :success
  end

  test "should create ind_direccion" do
    assert_difference('IndDireccion.count') do
      post ind_direcciones_url, params: { ind_direccion: { destino_id: @ind_direccion.destino_id, origen_id: @ind_direccion.origen_id } }
    end

    assert_redirected_to ind_direccion_url(IndDireccion.last)
  end

  test "should show ind_direccion" do
    get ind_direccion_url(@ind_direccion)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_direccion_url(@ind_direccion)
    assert_response :success
  end

  test "should update ind_direccion" do
    patch ind_direccion_url(@ind_direccion), params: { ind_direccion: { destino_id: @ind_direccion.destino_id, origen_id: @ind_direccion.origen_id } }
    assert_redirected_to ind_direccion_url(@ind_direccion)
  end

  test "should destroy ind_direccion" do
    assert_difference('IndDireccion.count', -1) do
      delete ind_direccion_url(@ind_direccion)
    end

    assert_redirected_to ind_direcciones_url
  end
end
