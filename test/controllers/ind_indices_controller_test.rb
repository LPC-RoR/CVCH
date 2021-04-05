require 'test_helper'

class IndIndicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_indice = ind_indices(:one)
  end

  test "should get index" do
    get ind_indices_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_indice_url
    assert_response :success
  end

  test "should create ind_indice" do
    assert_difference('IndIndice.count') do
      post ind_indices_url, params: { ind_indice: { class_name: @ind_indice.class_name, ind_clave_id: @ind_indice.ind_clave_id, objeto_id: @ind_indice.objeto_id } }
    end

    assert_redirected_to ind_indice_url(IndIndice.last)
  end

  test "should show ind_indice" do
    get ind_indice_url(@ind_indice)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_indice_url(@ind_indice)
    assert_response :success
  end

  test "should update ind_indice" do
    patch ind_indice_url(@ind_indice), params: { ind_indice: { class_name: @ind_indice.class_name, ind_clave_id: @ind_indice.ind_clave_id, objeto_id: @ind_indice.objeto_id } }
    assert_redirected_to ind_indice_url(@ind_indice)
  end

  test "should destroy ind_indice" do
    assert_difference('IndIndice.count', -1) do
      delete ind_indice_url(@ind_indice)
    end

    assert_redirected_to ind_indices_url
  end
end
