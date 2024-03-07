require 'test_helper'

class FiloDefInteraccionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_def_interaccion = filo_def_interacciones(:one)
  end

  test "should get index" do
    get filo_def_interacciones_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_def_interaccion_url
    assert_response :success
  end

  test "should create filo_def_interaccion" do
    assert_difference('FiloDefInteraccion.count') do
      post filo_def_interacciones_url, params: { filo_def_interaccion: { filo_def_interaccion: @filo_def_interaccion.filo_def_interaccion } }
    end

    assert_redirected_to filo_def_interaccion_url(FiloDefInteraccion.last)
  end

  test "should show filo_def_interaccion" do
    get filo_def_interaccion_url(@filo_def_interaccion)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_def_interaccion_url(@filo_def_interaccion)
    assert_response :success
  end

  test "should update filo_def_interaccion" do
    patch filo_def_interaccion_url(@filo_def_interaccion), params: { filo_def_interaccion: { filo_def_interaccion: @filo_def_interaccion.filo_def_interaccion } }
    assert_redirected_to filo_def_interaccion_url(@filo_def_interaccion)
  end

  test "should destroy filo_def_interaccion" do
    assert_difference('FiloDefInteraccion.count', -1) do
      delete filo_def_interaccion_url(@filo_def_interaccion)
    end

    assert_redirected_to filo_def_interacciones_url
  end
end
