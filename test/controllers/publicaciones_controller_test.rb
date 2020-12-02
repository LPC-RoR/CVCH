require 'test_helper'

class PublicacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @publicacion = publicaciones(:one)
  end

  test "should get index" do
    get publicaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_publicacion_url
    assert_response :success
  end

  test "should create publicacion" do
    assert_difference('Publicacion.count') do
      post publicaciones_url, params: { publicacion: { abstract: @publicacion.abstract, address: @publicacion.address, affiliation: @publicacion.affiliation, article_number: @publicacion.article_number, author: @publicacion.author, author_email: @publicacion.author_email, d_author: @publicacion.d_author, d_doi: @publicacion.d_doi, d_journal: @publicacion.d_journal, da: @publicacion.da, doi: @publicacion.doi, eissn: @publicacion.eissn, equipo_id: @publicacion.equipo_id, investigador_id: @publicacion.investigador_id, issn: @publicacion.issn, keywords: @publicacion.keywords, keywords_plus: @publicacion.keywords_plus, link: @publicacion.link, month: @publicacion.month, origen: @publicacion.origen, pages: @publicacion.pages, publisher: @publicacion.publisher, registro_id: @publicacion.registro_id, research_areas: @publicacion.research_areas, revista_id: @publicacion.revista_id, title: @publicacion.title, unique_id: @publicacion.unique_id, volume: @publicacion.volume, web_of_science_categories: @publicacion.web_of_science_categories, year: @publicacion.year } }
    end

    assert_redirected_to publicacion_url(Publicacion.last)
  end

  test "should show publicacion" do
    get publicacion_url(@publicacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_publicacion_url(@publicacion)
    assert_response :success
  end

  test "should update publicacion" do
    patch publicacion_url(@publicacion), params: { publicacion: { abstract: @publicacion.abstract, address: @publicacion.address, affiliation: @publicacion.affiliation, article_number: @publicacion.article_number, author: @publicacion.author, author_email: @publicacion.author_email, d_author: @publicacion.d_author, d_doi: @publicacion.d_doi, d_journal: @publicacion.d_journal, da: @publicacion.da, doi: @publicacion.doi, eissn: @publicacion.eissn, equipo_id: @publicacion.equipo_id, investigador_id: @publicacion.investigador_id, issn: @publicacion.issn, keywords: @publicacion.keywords, keywords_plus: @publicacion.keywords_plus, link: @publicacion.link, month: @publicacion.month, origen: @publicacion.origen, pages: @publicacion.pages, publisher: @publicacion.publisher, registro_id: @publicacion.registro_id, research_areas: @publicacion.research_areas, revista_id: @publicacion.revista_id, title: @publicacion.title, unique_id: @publicacion.unique_id, volume: @publicacion.volume, web_of_science_categories: @publicacion.web_of_science_categories, year: @publicacion.year } }
    assert_redirected_to publicacion_url(@publicacion)
  end

  test "should destroy publicacion" do
    assert_difference('Publicacion.count', -1) do
      delete publicacion_url(@publicacion)
    end

    assert_redirected_to publicaciones_url
  end
end
