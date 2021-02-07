require 'test_helper'

class DiccionariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @diccionario = diccionarios(:one)
  end

  test "should get index" do
    get diccionarios_url
    assert_response :success
  end

  test "should get new" do
    get new_diccionario_url
    assert_response :success
  end

  test "should create diccionario" do
    assert_difference('Diccionario.count') do
      post diccionarios_url, params: { diccionario: { concepto_id: @diccionario.concepto_id, instancia_id: @diccionario.instancia_id } }
    end

    assert_redirected_to diccionario_url(Diccionario.last)
  end

  test "should show diccionario" do
    get diccionario_url(@diccionario)
    assert_response :success
  end

  test "should get edit" do
    get edit_diccionario_url(@diccionario)
    assert_response :success
  end

  test "should update diccionario" do
    patch diccionario_url(@diccionario), params: { diccionario: { concepto_id: @diccionario.concepto_id, instancia_id: @diccionario.instancia_id } }
    assert_redirected_to diccionario_url(@diccionario)
  end

  test "should destroy diccionario" do
    assert_difference('Diccionario.count', -1) do
      delete diccionario_url(@diccionario)
    end

    assert_redirected_to diccionarios_url
  end
end
