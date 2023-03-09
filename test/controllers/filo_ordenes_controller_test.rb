require 'test_helper'

class FiloOrdenesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_orden = filo_ordenes(:one)
  end

  test "should get index" do
    get filo_ordenes_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_orden_url
    assert_response :success
  end

  test "should create filo_orden" do
    assert_difference('FiloOrden.count') do
      post filo_ordenes_url, params: { filo_orden: { filo_orden: @filo_orden.filo_orden, orden: @filo_orden.orden } }
    end

    assert_redirected_to filo_orden_url(FiloOrden.last)
  end

  test "should show filo_orden" do
    get filo_orden_url(@filo_orden)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_orden_url(@filo_orden)
    assert_response :success
  end

  test "should update filo_orden" do
    patch filo_orden_url(@filo_orden), params: { filo_orden: { filo_orden: @filo_orden.filo_orden, orden: @filo_orden.orden } }
    assert_redirected_to filo_orden_url(@filo_orden)
  end

  test "should destroy filo_orden" do
    assert_difference('FiloOrden.count', -1) do
      delete filo_orden_url(@filo_orden)
    end

    assert_redirected_to filo_ordenes_url
  end
end
