require 'test_helper'

class InstitucionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @institucion = instituciones(:one)
  end

  test "should get index" do
    get instituciones_url
    assert_response :success
  end

  test "should get new" do
    get new_institucion_url
    assert_response :success
  end

  test "should create institucion" do
    assert_difference('Institucion.count') do
      post instituciones_url, params: { institucion: { institucion: @institucion.institucion } }
    end

    assert_redirected_to institucion_url(Institucion.last)
  end

  test "should show institucion" do
    get institucion_url(@institucion)
    assert_response :success
  end

  test "should get edit" do
    get edit_institucion_url(@institucion)
    assert_response :success
  end

  test "should update institucion" do
    patch institucion_url(@institucion), params: { institucion: { institucion: @institucion.institucion } }
    assert_redirected_to institucion_url(@institucion)
  end

  test "should destroy institucion" do
    assert_difference('Institucion.count', -1) do
      delete institucion_url(@institucion)
    end

    assert_redirected_to instituciones_url
  end
end
