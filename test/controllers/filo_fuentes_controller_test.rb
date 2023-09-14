require 'test_helper'

class FiloFuentesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_fuente = filo_fuentes(:one)
  end

  test "should get index" do
    get filo_fuentes_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_fuente_url
    assert_response :success
  end

  test "should create filo_fuente" do
    assert_difference('FiloFuente.count') do
      post filo_fuentes_url, params: { filo_fuente: { filo_fuente: @filo_fuente.filo_fuente } }
    end

    assert_redirected_to filo_fuente_url(FiloFuente.last)
  end

  test "should show filo_fuente" do
    get filo_fuente_url(@filo_fuente)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_fuente_url(@filo_fuente)
    assert_response :success
  end

  test "should update filo_fuente" do
    patch filo_fuente_url(@filo_fuente), params: { filo_fuente: { filo_fuente: @filo_fuente.filo_fuente } }
    assert_redirected_to filo_fuente_url(@filo_fuente)
  end

  test "should destroy filo_fuente" do
    assert_difference('FiloFuente.count', -1) do
      delete filo_fuente_url(@filo_fuente)
    end

    assert_redirected_to filo_fuentes_url
  end
end
