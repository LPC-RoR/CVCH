require 'test_helper'

class InvestigadoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @investigador = investigadores(:one)
  end

  test "should get index" do
    get investigadores_url
    assert_response :success
  end

  test "should get new" do
    get new_investigador_url
    assert_response :success
  end

  test "should create investigador" do
    assert_difference('Investigador.count') do
      post investigadores_url, params: { investigador: { departamento_id: @investigador.departamento_id, email: @investigador.email, investigador: @investigador.investigador, orcid: @investigador.orcid } }
    end

    assert_redirected_to investigador_url(Investigador.last)
  end

  test "should show investigador" do
    get investigador_url(@investigador)
    assert_response :success
  end

  test "should get edit" do
    get edit_investigador_url(@investigador)
    assert_response :success
  end

  test "should update investigador" do
    patch investigador_url(@investigador), params: { investigador: { departamento_id: @investigador.departamento_id, email: @investigador.email, investigador: @investigador.investigador, orcid: @investigador.orcid } }
    assert_redirected_to investigador_url(@investigador)
  end

  test "should destroy investigador" do
    assert_difference('Investigador.count', -1) do
      delete investigador_url(@investigador)
    end

    assert_redirected_to investigadores_url
  end
end
