require 'test_helper'

class EtiquetasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @etiqueta = etiquetas(:one)
  end

  test "should get index" do
    get etiquetas_url
    assert_response :success
  end

  test "should get new" do
    get new_etiqueta_url
    assert_response :success
  end

  test "should create etiqueta" do
    assert_difference('Etiqueta.count') do
      post etiquetas_url, params: { etiqueta: { categoria_id: @etiqueta.categoria_id, especie_id: @etiqueta.especie_id, publicacion_id: @etiqueta.publicacion_id } }
    end

    assert_redirected_to etiqueta_url(Etiqueta.last)
  end

  test "should show etiqueta" do
    get etiqueta_url(@etiqueta)
    assert_response :success
  end

  test "should get edit" do
    get edit_etiqueta_url(@etiqueta)
    assert_response :success
  end

  test "should update etiqueta" do
    patch etiqueta_url(@etiqueta), params: { etiqueta: { categoria_id: @etiqueta.categoria_id, especie_id: @etiqueta.especie_id, publicacion_id: @etiqueta.publicacion_id } }
    assert_redirected_to etiqueta_url(@etiqueta)
  end

  test "should destroy etiqueta" do
    assert_difference('Etiqueta.count', -1) do
      delete etiqueta_url(@etiqueta)
    end

    assert_redirected_to etiquetas_url
  end
end
