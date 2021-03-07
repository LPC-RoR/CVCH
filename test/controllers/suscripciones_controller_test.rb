require 'test_helper'

class SuscripcionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @suscripcion = suscripciones(:one)
  end

  test "should get index" do
    get suscripciones_url
    assert_response :success
  end

  test "should get new" do
    get new_suscripcion_url
    assert_response :success
  end

  test "should create suscripcion" do
    assert_difference('Suscripcion.count') do
      post suscripciones_url, params: { suscripcion: { categoria_id: @suscripcion.categoria_id, perfil_id: @suscripcion.perfil_id } }
    end

    assert_redirected_to suscripcion_url(Suscripcion.last)
  end

  test "should show suscripcion" do
    get suscripcion_url(@suscripcion)
    assert_response :success
  end

  test "should get edit" do
    get edit_suscripcion_url(@suscripcion)
    assert_response :success
  end

  test "should update suscripcion" do
    patch suscripcion_url(@suscripcion), params: { suscripcion: { categoria_id: @suscripcion.categoria_id, perfil_id: @suscripcion.perfil_id } }
    assert_redirected_to suscripcion_url(@suscripcion)
  end

  test "should destroy suscripcion" do
    assert_difference('Suscripcion.count', -1) do
      delete suscripcion_url(@suscripcion)
    end

    assert_redirected_to suscripciones_url
  end
end
