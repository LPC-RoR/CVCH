require 'test_helper'

class IndIdeasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ind_idea = ind_ideas(:one)
  end

  test "should get index" do
    get ind_ideas_url
    assert_response :success
  end

  test "should get new" do
    get new_ind_idea_url
    assert_response :success
  end

  test "should create ind_idea" do
    assert_difference('IndIdea.count') do
      post ind_ideas_url, params: { ind_idea: { ind_estructura_id: @ind_idea.ind_estructura_id, ind_idea: @ind_idea.ind_idea } }
    end

    assert_redirected_to ind_idea_url(IndIdea.last)
  end

  test "should show ind_idea" do
    get ind_idea_url(@ind_idea)
    assert_response :success
  end

  test "should get edit" do
    get edit_ind_idea_url(@ind_idea)
    assert_response :success
  end

  test "should update ind_idea" do
    patch ind_idea_url(@ind_idea), params: { ind_idea: { ind_estructura_id: @ind_idea.ind_estructura_id, ind_idea: @ind_idea.ind_idea } }
    assert_redirected_to ind_idea_url(@ind_idea)
  end

  test "should destroy ind_idea" do
    assert_difference('IndIdea.count', -1) do
      delete ind_idea_url(@ind_idea)
    end

    assert_redirected_to ind_ideas_url
  end
end
