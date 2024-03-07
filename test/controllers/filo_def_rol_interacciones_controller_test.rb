require 'test_helper'

class FiloDefRolInteraccionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_def_rol_interaccion = filo_def_rol_interacciones(:one)
  end

  test "should get index" do
    get filo_def_rol_interacciones_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_def_rol_interaccion_url
    assert_response :success
  end

  test "should create filo_def_rol_interaccion" do
    assert_difference('FiloDefRolInteraccion.count') do
      post filo_def_rol_interacciones_url, params: { filo_def_rol_interaccion: { rol_a_id: @filo_def_rol_interaccion.rol_a_id, rol_b_id: @filo_def_rol_interaccion.rol_b_id } }
    end

    assert_redirected_to filo_def_rol_interaccion_url(FiloDefRolInteraccion.last)
  end

  test "should show filo_def_rol_interaccion" do
    get filo_def_rol_interaccion_url(@filo_def_rol_interaccion)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_def_rol_interaccion_url(@filo_def_rol_interaccion)
    assert_response :success
  end

  test "should update filo_def_rol_interaccion" do
    patch filo_def_rol_interaccion_url(@filo_def_rol_interaccion), params: { filo_def_rol_interaccion: { rol_a_id: @filo_def_rol_interaccion.rol_a_id, rol_b_id: @filo_def_rol_interaccion.rol_b_id } }
    assert_redirected_to filo_def_rol_interaccion_url(@filo_def_rol_interaccion)
  end

  test "should destroy filo_def_rol_interaccion" do
    assert_difference('FiloDefRolInteraccion.count', -1) do
      delete filo_def_rol_interaccion_url(@filo_def_rol_interaccion)
    end

    assert_redirected_to filo_def_rol_interacciones_url
  end
end
