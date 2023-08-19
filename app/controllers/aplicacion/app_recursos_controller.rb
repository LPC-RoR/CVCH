class Aplicacion::AppRecursosController < ApplicationController
  before_action :authenticate_usuario!, only: [:administracion, :procesos]
  before_action :inicia_sesion, only: [:administracion, :procesos, :home]

  include Sidebar
  include ProcesaEstructura

  helper_method :sort_column, :sort_direction

  def index
  end

  def home
    ultimos_ids = Publicacion.where(estado: 'publicada').order(created_at: :asc).last(10).map {|pub| pub.id}
    init_tabla( 'publicaciones', Publicacion.where(id: ultimos_ids).order(sort_column + " " + sort_direction), false )
    add_tabla( 'tema_ayudas', TemaAyuda.where(tipo: 'inicio').where(activo: true).order(:orden), false )
  end

  def ayuda
    carga_sidebar('Ayuda', params[:t])
#    carga_tutorial(@sb_elementos, @t)
  end

  def administracion
    carga_sidebar('Administración', params[:id])
  end

  def procesos

#    IndClave.all.each do |clave|
#      clave.delete if clave.ind_indices.empty?
#    end

#    inicio = IndPalabra.all.count

    IndPalabra.all.each do |palabra|
      if palabra.ind_clave.blank? and palabra.ind_indices.empty?
        palabra.delete
      end
    end

#    termino = IndPalabra.all.count

#    Publicacion.where(estado: 'publicada', author_email: 'indexada').last(500).each do |pub|
#        desindexa_registro(pub)
#        indexa_registro(pub)
#        pub.author_email = 'segundo'
#        pub.save
#    end


#    n_especies = Especie.all.count
#    n_sin_padre = Especie.where(filo_especie_id: nil).count
#    n_filo_especies = FiloEspecie.all.count
#    n_sub_especies = FiloEspecie.where(filo_elemento_id: nil).count
#    n_cvch = FiloEspecie.where(link_fuente: nil).count


#    Especie.all.each do |especie|
#      if especie.filo_especie.blank?
#        palabras = especie.especie.split(' ')
#        if palabras.length == 2
#          genero = FiloElemento.find_by(filo_elemento: palabras[0].strip.downcase)
#          unless genero.blank?
#            filo_especie = genero.filo_especies.create(filo_especie: especie.especie.strip.downcase)
#            filo_especie.especies << especie
#          end
#        elsif palabras.length == 3
#          genero = FiloElemento.find_by(filo_elemento: palabras[0].strip.downcase)
#          unless genero.blank?
#            s_filo_especie = "#{palabras[0].strip.downcase} #{palabras[1].strip.downcase}"
#            filo_especie = FiloEspecie.find_by(filo_especie: s_filo_especie)
#            filo_especie = genero.filo_especies.create(filo_especie: s_filo_especie) if filo_especie.blank?
#            unless filo_especie.blank?
#              sub_especie = FiloEspecie.create(filo_especie: especie.especie.strip.downcase)
#              filo_especie.children << sub_especie
#              sub_especie.especies << especie
#            end
#          end
#        end
#      end
#    end

#    redirect_to root_path, notice: "#{n_especies} : #{n_sin_padre} | #{n_filo_especies} : #{n_sub_especies} : #{n_cvch}"
    redirect_to root_path, notice: "Proceso terminado"
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def sort_column
      Publicacion.column_names.include?(params[:sort]) ? params[:sort] : "Author"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
