require 'test_helper'

class FiloElementosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_elemento = filo_elementos(:one)
  end

  test "should get index" do
    get filo_elementos_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_elemento_url
    assert_response :success
  end

  test "should create filo_elemento" do
    assert_difference('FiloElemento.count') do
      post filo_elementos_url, params: { filo_elemento: { filo_elemento: @filo_elemento.filo_elemento } }
    end

    assert_redirected_to filo_elemento_url(FiloElemento.last)
  end

  test "should show filo_elemento" do
    get filo_elemento_url(@filo_elemento)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_elemento_url(@filo_elemento)
    assert_response :success
  end

  test "should update filo_elemento" do
    patch filo_elemento_url(@filo_elemento), params: { filo_elemento: { filo_elemento: @filo_elemento.filo_elemento } }
    assert_redirected_to filo_elemento_url(@filo_elemento)
  end

  test "should destroy filo_elemento" do
    assert_difference('FiloElemento.count', -1) do
      delete filo_elemento_url(@filo_elemento)
    end

    assert_redirected_to filo_elementos_url
  end
end
