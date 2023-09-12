require 'test_helper'

class FiloSinonimosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_sinonimo = filo_sinonimos(:one)
  end

  test "should get index" do
    get filo_sinonimos_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_sinonimo_url
    assert_response :success
  end

  test "should create filo_sinonimo" do
    assert_difference('FiloSinonimo.count') do
      post filo_sinonimos_url, params: { filo_sinonimo: { filo_especie_id: @filo_sinonimo.filo_especie_id, filo_sinonimo: @filo_sinonimo.filo_sinonimo, tipo: @filo_sinonimo.tipo } }
    end

    assert_redirected_to filo_sinonimo_url(FiloSinonimo.last)
  end

  test "should show filo_sinonimo" do
    get filo_sinonimo_url(@filo_sinonimo)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_sinonimo_url(@filo_sinonimo)
    assert_response :success
  end

  test "should update filo_sinonimo" do
    patch filo_sinonimo_url(@filo_sinonimo), params: { filo_sinonimo: { filo_especie_id: @filo_sinonimo.filo_especie_id, filo_sinonimo: @filo_sinonimo.filo_sinonimo, tipo: @filo_sinonimo.tipo } }
    assert_redirected_to filo_sinonimo_url(@filo_sinonimo)
  end

  test "should destroy filo_sinonimo" do
    assert_difference('FiloSinonimo.count', -1) do
      delete filo_sinonimo_url(@filo_sinonimo)
    end

    assert_redirected_to filo_sinonimos_url
  end
end
