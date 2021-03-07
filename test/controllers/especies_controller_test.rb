require 'test_helper'

class EspeciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @especie = especies(:one)
  end

  test "should get index" do
    get especies_url
    assert_response :success
  end

  test "should get new" do
    get new_especie_url
    assert_response :success
  end

  test "should create especie" do
    assert_difference('Especie.count') do
      post especies_url, params: { especie: { especie: @especie.especie } }
    end

    assert_redirected_to especie_url(Especie.last)
  end

  test "should show especie" do
    get especie_url(@especie)
    assert_response :success
  end

  test "should get edit" do
    get edit_especie_url(@especie)
    assert_response :success
  end

  test "should update especie" do
    patch especie_url(@especie), params: { especie: { especie: @especie.especie } }
    assert_redirected_to especie_url(@especie)
  end

  test "should destroy especie" do
    assert_difference('Especie.count', -1) do
      delete especie_url(@especie)
    end

    assert_redirected_to especies_url
  end
end
