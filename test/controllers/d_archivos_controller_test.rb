require "test_helper"

class DArchivosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @d_archivo = d_archivos(:one)
  end

  test "should get index" do
    get d_archivos_url
    assert_response :success
  end

  test "should get new" do
    get new_d_archivo_url
    assert_response :success
  end

  test "should create d_archivo" do
    assert_difference("DArchivo.count") do
      post d_archivos_url, params: { d_archivo: { archivo: @d_archivo.archivo } }
    end

    assert_redirected_to d_archivo_url(DArchivo.last)
  end

  test "should show d_archivo" do
    get d_archivo_url(@d_archivo)
    assert_response :success
  end

  test "should get edit" do
    get edit_d_archivo_url(@d_archivo)
    assert_response :success
  end

  test "should update d_archivo" do
    patch d_archivo_url(@d_archivo), params: { d_archivo: { archivo: @d_archivo.archivo } }
    assert_redirected_to d_archivo_url(@d_archivo)
  end

  test "should destroy d_archivo" do
    assert_difference("DArchivo.count", -1) do
      delete d_archivo_url(@d_archivo)
    end

    assert_redirected_to d_archivos_url
  end
end
