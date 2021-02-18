require 'test_helper'

class TemaAyudasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tema_ayuda = tema_ayudas(:one)
  end

  test "should get index" do
    get tema_ayudas_url
    assert_response :success
  end

  test "should get new" do
    get new_tema_ayuda_url
    assert_response :success
  end

  test "should create tema_ayuda" do
    assert_difference('TemaAyuda.count') do
      post tema_ayudas_url, params: { tema_ayuda: { detalle: @tema_ayuda.detalle, orden: @tema_ayuda.orden, tema_ayuda: @tema_ayuda.tema_ayuda, tipo: @tema_ayuda.tipo } }
    end

    assert_redirected_to tema_ayuda_url(TemaAyuda.last)
  end

  test "should show tema_ayuda" do
    get tema_ayuda_url(@tema_ayuda)
    assert_response :success
  end

  test "should get edit" do
    get edit_tema_ayuda_url(@tema_ayuda)
    assert_response :success
  end

  test "should update tema_ayuda" do
    patch tema_ayuda_url(@tema_ayuda), params: { tema_ayuda: { detalle: @tema_ayuda.detalle, orden: @tema_ayuda.orden, tema_ayuda: @tema_ayuda.tema_ayuda, tipo: @tema_ayuda.tipo } }
    assert_redirected_to tema_ayuda_url(@tema_ayuda)
  end

  test "should destroy tema_ayuda" do
    assert_difference('TemaAyuda.count', -1) do
      delete tema_ayuda_url(@tema_ayuda)
    end

    assert_redirected_to tema_ayudas_url
  end
end
