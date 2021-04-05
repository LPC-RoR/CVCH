require 'test_helper'

class IndPalabrasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_palabra = ind_palabras(:one)
  end

  test "should get index" do
    get ind_palabras_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_palabra_url
    assert_response :success
  end

  test "should create ind_palabra" do
    assert_difference('IndPalabra.count') do
      post ind_palabras_url, params: { ind_palabra: { ind_clave_id: @ind_palabra.ind_clave_id, ind_lenguaje_id: @ind_palabra.ind_lenguaje_id, ind_palabra: @ind_palabra.ind_palabra } }
    end

    assert_redirected_to ind_palabra_url(IndPalabra.last)
  end

  test "should show ind_palabra" do
    get ind_palabra_url(@ind_palabra)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_palabra_url(@ind_palabra)
    assert_response :success
  end

  test "should update ind_palabra" do
    patch ind_palabra_url(@ind_palabra), params: { ind_palabra: { ind_clave_id: @ind_palabra.ind_clave_id, ind_lenguaje_id: @ind_palabra.ind_lenguaje_id, ind_palabra: @ind_palabra.ind_palabra } }
    assert_redirected_to ind_palabra_url(@ind_palabra)
  end

  test "should destroy ind_palabra" do
    assert_difference('IndPalabra.count', -1) do
      delete ind_palabra_url(@ind_palabra)
    end

    assert_redirected_to ind_palabras_url
  end
end
