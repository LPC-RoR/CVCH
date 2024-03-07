require 'test_helper'

class FiloInteraccionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filo_interaccion = filo_interacciones(:one)
  end

  test "should get index" do
    get filo_interacciones_url
    assert_response :success
  end

  test "should get new" do
    get new_filo_interaccion_url
    assert_response :success
  end

  test "should create filo_interaccion" do
    assert_difference('FiloInteraccion.count') do
      post filo_interacciones_url, params: { filo_interaccion: { filo_def_interaccion_id: @filo_interaccion.filo_def_interaccion_id, publicacion_id: @filo_interaccion.publicacion_id } }
    end

    assert_redirected_to filo_interaccion_url(FiloInteraccion.last)
  end

  test "should show filo_interaccion" do
    get filo_interaccion_url(@filo_interaccion)
    assert_response :success
  end

  test "should get edit" do
    get edit_filo_interaccion_url(@filo_interaccion)
    assert_response :success
  end

  test "should update filo_interaccion" do
    patch filo_interaccion_url(@filo_interaccion), params: { filo_interaccion: { filo_def_interaccion_id: @filo_interaccion.filo_def_interaccion_id, publicacion_id: @filo_interaccion.publicacion_id } }
    assert_redirected_to filo_interaccion_url(@filo_interaccion)
  end

  test "should destroy filo_interaccion" do
    assert_difference('FiloInteraccion.count', -1) do
      delete filo_interaccion_url(@filo_interaccion)
    end

    assert_redirected_to filo_interacciones_url
  end
end
