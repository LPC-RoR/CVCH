require 'test_helper'

class FiloConfElemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_conf_elem = filo_conf_elems(:one)
  end

  test "should get index" do
    get filo_conf_elems_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_conf_elem_url
    assert_response :success
  end

  test "should create filo_conf_elem" do
    assert_difference('FiloConfElem.count') do
      post filo_conf_elems_url, params: { filo_conf_elem: { filo_conflicto_id: @filo_conf_elem.filo_conflicto_id, filo_elem_class: @filo_conf_elem.filo_elem_class, filo_elem_id: @filo_conf_elem.filo_elem_id } }
    end

    assert_redirected_to filo_conf_elem_url(FiloConfElem.last)
  end

  test "should show filo_conf_elem" do
    get filo_conf_elem_url(@filo_conf_elem)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_conf_elem_url(@filo_conf_elem)
    assert_response :success
  end

  test "should update filo_conf_elem" do
    patch filo_conf_elem_url(@filo_conf_elem), params: { filo_conf_elem: { filo_conflicto_id: @filo_conf_elem.filo_conflicto_id, filo_elem_class: @filo_conf_elem.filo_elem_class, filo_elem_id: @filo_conf_elem.filo_elem_id } }
    assert_redirected_to filo_conf_elem_url(@filo_conf_elem)
  end

  test "should destroy filo_conf_elem" do
    assert_difference('FiloConfElem.count', -1) do
      delete filo_conf_elem_url(@filo_conf_elem)
    end

    assert_redirected_to filo_conf_elems_url
  end
end
