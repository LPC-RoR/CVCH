require 'test_helper'

class InstanciasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @instancia = instancias(:one)
  end

  test "should get index" do
    get instancias_url
    assert_response :success
  end

  test "should get new" do
    get new_instancia_url
    assert_response :success
  end

  test "should create instancia" do
    assert_difference('Instancia.count') do
      post instancias_url, params: { instancia: { concepto_id: @instancia.concepto_id, instancia: @instancia.instancia, sha1: @instancia.sha1 } }
    end

    assert_redirected_to instancia_url(Instancia.last)
  end

  test "should show instancia" do
    get instancia_url(@instancia)
    assert_response :success
  end

  test "should get edit" do
    get edit_instancia_url(@instancia)
    assert_response :success
  end

  test "should update instancia" do
    patch instancia_url(@instancia), params: { instancia: { concepto_id: @instancia.concepto_id, instancia: @instancia.instancia, sha1: @instancia.sha1 } }
    assert_redirected_to instancia_url(@instancia)
  end

  test "should destroy instancia" do
    assert_difference('Instancia.count', -1) do
      delete instancia_url(@instancia)
    end

    assert_redirected_to instancias_url
  end
end
