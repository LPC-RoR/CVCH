require 'test_helper'

class HLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @h_link = h_links(:one)
  end

  test "should get index" do
    get h_links_url
    assert_response :success
  end

  test "should get new" do
    get new_h_link_url
    assert_response :success
  end

  test "should create h_link" do
    assert_difference('HLink.count') do
      post h_links_url, params: { h_link: { activo: @h_link.activo, link: @h_link.link, owner_class: @h_link.owner_class, owner_id: @h_link.owner_id, texto: @h_link.texto, tipo: @h_link.tipo } }
    end

    assert_redirected_to h_link_url(HLink.last)
  end

  test "should show h_link" do
    get h_link_url(@h_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_h_link_url(@h_link)
    assert_response :success
  end

  test "should update h_link" do
    patch h_link_url(@h_link), params: { h_link: { activo: @h_link.activo, link: @h_link.link, owner_class: @h_link.owner_class, owner_id: @h_link.owner_id, texto: @h_link.texto, tipo: @h_link.tipo } }
    assert_redirected_to h_link_url(@h_link)
  end

  test "should destroy h_link" do
    assert_difference('HLink.count', -1) do
      delete h_link_url(@h_link)
    end

    assert_redirected_to h_links_url
  end
end
