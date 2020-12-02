require "application_system_test_case"

class PublicacionesTest < ApplicationSystemTestCase
  setup do
    @publicacion = publicaciones(:one)
  end

  test "visiting the index" do
    visit publicaciones_url
    assert_selector "h1", text: "Publicaciones"
  end

  test "creating a Publicacion" do
    visit publicaciones_url
    click_on "New Publicacion"

    fill_in "Abstract", with: @publicacion.abstract
    fill_in "Address", with: @publicacion.address
    fill_in "Affiliation", with: @publicacion.affiliation
    fill_in "Article number", with: @publicacion.article_number
    fill_in "Author", with: @publicacion.author
    fill_in "Author email", with: @publicacion.author_email
    fill_in "D author", with: @publicacion.d_author
    fill_in "D doi", with: @publicacion.d_doi
    fill_in "D journal", with: @publicacion.d_journal
    fill_in "Da", with: @publicacion.da
    fill_in "Doi", with: @publicacion.doi
    fill_in "Eissn", with: @publicacion.eissn
    fill_in "Equipo", with: @publicacion.equipo_id
    fill_in "Investigador", with: @publicacion.investigador_id
    fill_in "Issn", with: @publicacion.issn
    fill_in "Keywords", with: @publicacion.keywords
    fill_in "Keywords plus", with: @publicacion.keywords_plus
    fill_in "Link", with: @publicacion.link
    fill_in "Month", with: @publicacion.month
    fill_in "Origen", with: @publicacion.origen
    fill_in "Pages", with: @publicacion.pages
    fill_in "Publisher", with: @publicacion.publisher
    fill_in "Registro", with: @publicacion.registro_id
    fill_in "Research areas", with: @publicacion.research_areas
    fill_in "Revista", with: @publicacion.revista_id
    fill_in "Title", with: @publicacion.title
    fill_in "Unique", with: @publicacion.unique_id
    fill_in "Volume", with: @publicacion.volume
    fill_in "Web of science categories", with: @publicacion.web_of_science_categories
    fill_in "Year", with: @publicacion.year
    click_on "Create Publicacion"

    assert_text "Publicacion was successfully created"
    click_on "Back"
  end

  test "updating a Publicacion" do
    visit publicaciones_url
    click_on "Edit", match: :first

    fill_in "Abstract", with: @publicacion.abstract
    fill_in "Address", with: @publicacion.address
    fill_in "Affiliation", with: @publicacion.affiliation
    fill_in "Article number", with: @publicacion.article_number
    fill_in "Author", with: @publicacion.author
    fill_in "Author email", with: @publicacion.author_email
    fill_in "D author", with: @publicacion.d_author
    fill_in "D doi", with: @publicacion.d_doi
    fill_in "D journal", with: @publicacion.d_journal
    fill_in "Da", with: @publicacion.da
    fill_in "Doi", with: @publicacion.doi
    fill_in "Eissn", with: @publicacion.eissn
    fill_in "Equipo", with: @publicacion.equipo_id
    fill_in "Investigador", with: @publicacion.investigador_id
    fill_in "Issn", with: @publicacion.issn
    fill_in "Keywords", with: @publicacion.keywords
    fill_in "Keywords plus", with: @publicacion.keywords_plus
    fill_in "Link", with: @publicacion.link
    fill_in "Month", with: @publicacion.month
    fill_in "Origen", with: @publicacion.origen
    fill_in "Pages", with: @publicacion.pages
    fill_in "Publisher", with: @publicacion.publisher
    fill_in "Registro", with: @publicacion.registro_id
    fill_in "Research areas", with: @publicacion.research_areas
    fill_in "Revista", with: @publicacion.revista_id
    fill_in "Title", with: @publicacion.title
    fill_in "Unique", with: @publicacion.unique_id
    fill_in "Volume", with: @publicacion.volume
    fill_in "Web of science categories", with: @publicacion.web_of_science_categories
    fill_in "Year", with: @publicacion.year
    click_on "Update Publicacion"

    assert_text "Publicacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Publicacion" do
    visit publicaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Publicacion was successfully destroyed"
  end
end
