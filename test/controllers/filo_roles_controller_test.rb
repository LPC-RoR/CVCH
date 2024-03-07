require 'test_helper'

class FiloRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_rol = filo_roles(:one)
  end

  test "should get index" do
    get filo_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_rol_url
    assert_response :success
  end

  test "should create filo_rol" do
    assert_difference('FiloRol.count') do
      post filo_roles_url, params: { filo_rol: { filo_especie_id: @filo_rol.filo_especie_id, filo_interaccion_id: @filo_rol.filo_interaccion_id, filo_rol: @filo_rol.filo_rol } }
    end

    assert_redirected_to filo_rol_url(FiloRol.last)
  end

  test "should show filo_rol" do
    get filo_rol_url(@filo_rol)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_rol_url(@filo_rol)
    assert_response :success
  end

  test "should update filo_rol" do
    patch filo_rol_url(@filo_rol), params: { filo_rol: { filo_especie_id: @filo_rol.filo_especie_id, filo_interaccion_id: @filo_rol.filo_interaccion_id, filo_rol: @filo_rol.filo_rol } }
    assert_redirected_to filo_rol_url(@filo_rol)
  end

  test "should destroy filo_rol" do
    assert_difference('FiloRol.count', -1) do
      delete filo_rol_url(@filo_rol)
    end

    assert_redirected_to filo_roles_url
  end
end
