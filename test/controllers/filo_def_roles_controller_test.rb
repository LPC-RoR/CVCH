require 'test_helper'

class FiloDefRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_def_rol = filo_def_roles(:one)
  end

  test "should get index" do
    get filo_def_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_def_rol_url
    assert_response :success
  end

  test "should create filo_def_rol" do
    assert_difference('FiloDefRol.count') do
      post filo_def_roles_url, params: { filo_def_rol: { filo_def_rol: @filo_def_rol.filo_def_rol } }
    end

    assert_redirected_to filo_def_rol_url(FiloDefRol.last)
  end

  test "should show filo_def_rol" do
    get filo_def_rol_url(@filo_def_rol)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_def_rol_url(@filo_def_rol)
    assert_response :success
  end

  test "should update filo_def_rol" do
    patch filo_def_rol_url(@filo_def_rol), params: { filo_def_rol: { filo_def_rol: @filo_def_rol.filo_def_rol } }
    assert_redirected_to filo_def_rol_url(@filo_def_rol)
  end

  test "should destroy filo_def_rol" do
    assert_difference('FiloDefRol.count', -1) do
      delete filo_def_rol_url(@filo_def_rol)
    end

    assert_redirected_to filo_def_roles_url
  end
end
