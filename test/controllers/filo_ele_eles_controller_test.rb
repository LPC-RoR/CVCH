require 'test_helper'

class FiloEleElesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_ele_el = filo_ele_eles(:one)
  end

  test "should get index" do
    get filo_ele_eles_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_ele_el_url
    assert_response :success
  end

  test "should create filo_ele_el" do
    assert_difference('FiloEleEle.count') do
      post filo_ele_eles_url, params: { filo_ele_el: { child_id: @filo_ele_el.child_id, parent_id: @filo_ele_el.parent_id } }
    end

    assert_redirected_to filo_ele_el_url(FiloEleEle.last)
  end

  test "should show filo_ele_el" do
    get filo_ele_el_url(@filo_ele_el)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_ele_el_url(@filo_ele_el)
    assert_response :success
  end

  test "should update filo_ele_el" do
    patch filo_ele_el_url(@filo_ele_el), params: { filo_ele_el: { child_id: @filo_ele_el.child_id, parent_id: @filo_ele_el.parent_id } }
    assert_redirected_to filo_ele_el_url(@filo_ele_el)
  end

  test "should destroy filo_ele_el" do
    assert_difference('FiloEleEle.count', -1) do
      delete filo_ele_el_url(@filo_ele_el)
    end

    assert_redirected_to filo_ele_eles_url
  end
end
