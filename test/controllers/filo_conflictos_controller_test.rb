require 'test_helper'

class FiloConflictosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_conflicto = filo_conflictos(:one)
  end

  test "should get index" do
    get filo_conflictos_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_conflicto_url
    assert_response :success
  end

  test "should create filo_conflicto" do
    assert_difference('FiloConflicto.count') do
      post filo_conflictos_url, params: { filo_conflicto: { app_perfil_id: @filo_conflicto.app_perfil_id, detalle: @filo_conflicto.detalle, filo_conflicto: @filo_conflicto.filo_conflicto, resuelto: @filo_conflicto.resuelto } }
    end

    assert_redirected_to filo_conflicto_url(FiloConflicto.last)
  end

  test "should show filo_conflicto" do
    get filo_conflicto_url(@filo_conflicto)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_conflicto_url(@filo_conflicto)
    assert_response :success
  end

  test "should update filo_conflicto" do
    patch filo_conflicto_url(@filo_conflicto), params: { filo_conflicto: { app_perfil_id: @filo_conflicto.app_perfil_id, detalle: @filo_conflicto.detalle, filo_conflicto: @filo_conflicto.filo_conflicto, resuelto: @filo_conflicto.resuelto } }
    assert_redirected_to filo_conflicto_url(@filo_conflicto)
  end

  test "should destroy filo_conflicto" do
    assert_difference('FiloConflicto.count', -1) do
      delete filo_conflicto_url(@filo_conflicto)
    end

    assert_redirected_to filo_conflictos_url
  end
end
