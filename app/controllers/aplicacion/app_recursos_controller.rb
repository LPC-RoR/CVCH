class Aplicacion::AppRecursosController < ApplicationController
  before_action :authenticate_usuario!, only: [:administracion, :procesos]
  before_action :inicia_sesion, only: [:administracion, :procesos, :home]

  include ProcesaEstructura

  helper_method :sort_column, :sort_direction

  def index
  end

  def home
    # DEPRECATED
  end

  def ayuda
#    carga_tutorial(@sb_elementos, @t)
  end

  def administracion
  end

  def procesos

    # Usado para recuperar la estructura de elementos FiloElemento
    # Se borran todas las relaaciones entre ellos para procesar, para evitar loops accidentales
    FiloEleEle.delete_all
    retornados = 0
    no_encontrados = 0
    duplicados = 0
    FiloElemento.all.each do |filo_elemento|
    hijos = filo_elemento.list_field.blank? ? [] : filo_elemento.list_field.downcase.split(';')

      unless hijos.empty?
        hijos.each do |hijo|
          filo_hijo = FiloElemento.find_by(filo_elemento: hijo)
          unless filo_hijo.blank?
            unless filo_hijo.parent.present?
              filo_elemento.children << filo_hijo
              retornados += 1
            else
              duplicados += 1
            end
          else
            no_encontrados += 1
          end
        end
      end
    end

    FiloEspEsp.delete_all
    FiloEspecie.all.each do |filo_especie|
      words = filo_especie.filo_especie.split(' ')
      tipo_especie = words.length > 2 ? 'subespecie' : 'especie' 
      if tipo_especie == 'especie'
        genero = filo_especie.filo_especie.split(' ')[0]
        filo_genero = FiloElemento.find_by(filo_elemento: genero)
        filo_especie.filo_elemento_id = filo_genero.blank? ? nil : filo_genero.id
        filo_especie.save
      else
        especie = "#{words[0]} #{words[1]}"
        especie_padre = FiloEspecie.find_by(filo_especie: especie)
        especie_padre.children << filo_especie unless especie_padre.blank?
      end
    end

    Especie.all.each do |especie|
      genero = especie.especie.split(' ')[0]
      filo_especie = FiloEspecie.find_by(filo_especie: especie.especie)
      if filo_especie.blank?
        filo_genero = FiloElemento.find_by(filo_elemento: genero)
        filo_especie = filo_genero.filo_especies.create(filo_especie: especie.especie) unless filo_genero.blank?
      end
      especie.filo_especie_id = filo_especie.blank? ? nil : filo_especie.id
      especie.save
    end

    redirect_to root_path, notice: "FiloEleEle #{FiloEleEle.all.count} retornados #{retornados} duplicados #{duplicados} no encontrados #{no_encontrados}"
#    redirect_to root_path
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
  