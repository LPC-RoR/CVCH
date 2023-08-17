class Aplicacion::AppRecursosController < ApplicationController
  before_action :authenticate_usuario!, only: [:administracion, :procesos]
  before_action :inicia_sesion, only: [:administracion, :procesos, :home]

  include Sidebar

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

    FiloElemento.all.each do |elemento|
      if elemento.filo_elemento != limpia_nombre(elemento.filo_elemento)
        elemento.filo_elemento = limpia_nombre(elemento.filo_elemento)
        elemento.save
      end
    end

    Especie.all.each do |etiqueta|
      if etiqueta.especie != limpia_nombre(etiqueta.especie)
        # Lo primero es unificar las etiquetas
        # preguntamos si hay una etiqueta limpia
        limpia = Especie.find_by(especie: limpia_nombre(etiqueta.especie))
        if limpia.present? and limpia.id != etiqueta.id
          # Existe etiqueta con nombre limpio
          # se traspasan publicaciones a la etiqueta limpia
          unless etiqueta.publicaciones.empty?
            etiqueta.publicaciones.each do |pub|
              limpia.publicaciones << pub
              etiqueta.publicaciones.delete(pub)
            end
          end
          if etiqueta.filo_especie.present?
            filo_especie = etiqueta.filo_especie
            filo_especie.filo_especie = limpia_nombre(filo_especie.filo_especie)
            filo_especie.save

            etiqueta.delete if etiqueta.publicaciones.empty?
            filo_especie.especies << limpia if limpia.filo_especie.blank?
          end
        else
          # no existe etiqueta limpia
          etiqueta.especie = limpia_nombre(etiqueta.especie)
          etiqueta.save
          if etiqueta.filo_especie.present?
            filo_especie = etiqueta.filo_especie
            filo_especie.filo_especie = limpia_nombre(filo_especie.filo_especie)
            filo_especie.save
          end
        end
      end
    end

    FiloEspecie.all.each do |filo_especie|
      if filo_especie.filo_especie != limpia_nombre(filo_especie.filo_especie)
        if filo_especie.especies.empty?
          filo_especie.filo_especie = limpia_nombre(filo_especie.filo_especie)
          filo_especie.save
        end
      end
    end


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
