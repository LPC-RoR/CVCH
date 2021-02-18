require 'test_helper'

class MejorasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mejora = mejoras(:one)
  end

  test "should get index" do
    get mejoras_url
    assert_response :success
  end

  test "should get new" do
    get new_mejora_url
    assert_response :success
  end

  test "should create mejora" do
    assert_difference('Mejora.count') do
      post mejoras_url, params: { mejora: { detalle: @mejora.detalle, mejora: @mejora.mejora, publicacion_id: @mejora.publicacion_id } }
    end

    assert_redirected_to mejora_url(Mejora.last)
  end

  test "should show mejora" do
    get mejora_url(@mejora)
    assert_response :success
  end

  test "should get edit" do
    get edit_mejora_url(@mejora)
    assert_response :success
  end

  test "should update mejora" do
    patch mejora_url(@mejora), params: { mejora: { detalle: @mejora.detalle, mejora: @mejora.mejora, publicacion_id: @mejora.publicacion_id } }
    assert_redirected_to mejora_url(@mejora)
  end

  test "should destroy mejora" do
    assert_difference('Mejora.count', -1) do
      delete mejora_url(@mejora)
    end

    assert_redirected_to mejoras_url
  end
end
