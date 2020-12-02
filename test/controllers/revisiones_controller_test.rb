require 'test_helper'

class RevisionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @revision = revisiones(:one)
  end

  test "should get index" do
    get revisiones_url
    assert_response :success
  end

  test "should get new" do
    get new_revision_url
    assert_response :success
  end

  test "should create revision" do
    assert_difference('Revision.count') do
      post revisiones_url, params: { revision: {  } }
    end

    assert_redirected_to revision_url(Revision.last)
  end

  test "should show revision" do
    get revision_url(@revision)
    assert_response :success
  end

  test "should get edit" do
    get edit_revision_url(@revision)
    assert_response :success
  end

  test "should update revision" do
    patch revision_url(@revision), params: { revision: {  } }
    assert_redirected_to revision_url(@revision)
  end

  test "should destroy revision" do
    assert_difference('Revision.count', -1) do
      delete revision_url(@revision)
    end

    assert_redirected_to revisiones_url
  end
end
