require 'test_helper'

class FiloCriteriosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_criterio = filo_criterios(:one)
  end

  test "should get index" do
    get filo_criterios_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_criterio_url
    assert_response :success
  end

  test "should create filo_criterio" do
    assert_difference('FiloCriterio.count') do
      post filo_criterios_url, params: { filo_criterio: { criterio: @filo_criterio.criterio, filo_conflicto_id: @filo_criterio.filo_conflicto_id, fuente: @filo_criterio.fuente, link_fuente: @filo_criterio.link_fuente, problema: @filo_criterio.problema } }
    end

    assert_redirected_to filo_criterio_url(FiloCriterio.last)
  end

  test "should show filo_criterio" do
    get filo_criterio_url(@filo_criterio)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_criterio_url(@filo_criterio)
    assert_response :success
  end

  test "should update filo_criterio" do
    patch filo_criterio_url(@filo_criterio), params: { filo_criterio: { criterio: @filo_criterio.criterio, filo_conflicto_id: @filo_criterio.filo_conflicto_id, fuente: @filo_criterio.fuente, link_fuente: @filo_criterio.link_fuente, problema: @filo_criterio.problema } }
    assert_redirected_to filo_criterio_url(@filo_criterio)
  end

  test "should destroy filo_criterio" do
    assert_difference('FiloCriterio.count', -1) do
      delete filo_criterio_url(@filo_criterio)
    end

    assert_redirected_to filo_criterios_url
  end
end
