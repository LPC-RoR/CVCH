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
#    Clasificacion.all.each do |clasificacion|
#      if clasificacion.paper.blank?
#        clasificacion.delete
#      end
#    end

#    Carga.delete_all

#    IndClave.all.each do |clave|
#      if clave.ind_indices.empty?
#        clave.delete
#      elsif clave.ind_palabras.empty?
#        clave.ind_indices.each do |indice|
#          indice.delete
#        end
#        clave.delete
#      else
#        clave.ind_indices.each do |indice|
#          pubs = Publicacion.where(id: indice.objeto_id.to_i)
#          indice.delete if pubs.empty?
#        end
#        clave.delete if clave.ind_indices.empty?
#      end
#    end

#    inicio = IndPalabra.all.count

#    IndPalabra.where(proceso: 'primer').first(2000).each do |palabra|
#      if palabra.ind_clave.blank?
#          palabra.ind_clave_id = nil
#          palabra.save
#      end
#      if palabra.ind_indices.empty?
#        palabra.delete 
#      else
#        palabra.proceso = 'segundo'
#        palabra.save
#      end
#    end

#    termino = IndPalabra.all.count

#    Publicacion.where(estado: 'publicada', author_email: 'segundo').last(200).each do |pub|
#        desindexa_registro(pub)
#        indexa_registro(pub)
#        pub.author_email = 'tercero'
#        pub.save
#    end


    n_especies = Especie.all.count
    n_sin_padre = Especie.where(filo_especie_id: nil).count
    n_filo_especies = FiloEspecie.all.count
    n_sub_especies = FiloEspecie.where(filo_elemento_id: nil).count
    n_cvch = FiloEspecie.where(link_fuente: nil).count

#    base_ids = FiloElemento.all.map {|fe| fe.id unless (fe.parent.present? or fe.revisar == false)}.compact
#    FiloElemento.where(id: base_ids).each do |genero|
#      genero.delete if genero.filo_especies.empty?
#      genero.filo_especies.each do |filo_especie|
#        filo_especie.delete if filo_especie.especies.empty?
#      end
#    end

    Especie.where(filo_especie_id: nil).each do |especie|
      if especie.publicaciones.empty?
        especie.delete
      else
        especie_a_estructura(especie)
      end
    end

    redirect_to root_path, notice: "#{n_especies} : #{n_sin_padre} | #{n_filo_especies} : #{n_sub_especies} : #{n_cvch}"
#    redirect_to root_path, notice: "Proceso terminado #{IndClave.all.count} : #{IndPalabra.all.count}"
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
  