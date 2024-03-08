class Aplicacion::TablasController < ApplicationController

  # GET /tablas or /tablas.json
  def index

    @indice = params[:tb].blank? ? first_tabla_index(:admin) : params[:tb].to_i

    case tb_item(:admin, @indice)
    when 'Imagenes' #HImagen, Imágenes del HOME
      set_tabla('h_imagenes', HImagen.all.order(:nombre), false)
    when 'Regiones & Lugares' #Regiones
      set_tabla('regiones', Region.all.order(:orden), false)
      set_tabla('eco_lugares', EcoLugar.all.order(:eco_lugar), false)
    when 'Áreas & Categorías' #Enlaces
      set_tabla('areas', Area.all.order(:area), false)
      set_tabla('categorias', Categoria.all.order(:categoria), false)
    when 'Tipos' #Variables del calendario
      set_tabla('filo_ordenes', FiloOrden.all.order(:orden), false)
      set_tabla('filo_tipo_especies', FiloTipoEspecie.all.order(:filo_tipo_especie), false)
    when 'Agenda' #Variables del calendario
      set_tabla('age_usuarios', AgeUsuario.where(owner_class: '', owner_id: nil), true)
    when 'Tarifas generales' #Tarifas Generales
      set_tabla('tar_tarifas', TarTarifa.where(owner_class: ''), false)
      set_tabla('tar_servicios', TarServicio.where(owner_class: ''), false)
    when 'Tipos' # Tipos
      set_tabla('tipo_causas', TipoCausa.all.order(:tipo_causa), false)
      set_tabla('tipo_asesorias', TipoAsesoria.all.order(:tipo_asesoria), false)
    when 'Categorías & Fuentes' #Tablas secundarias
      set_tabla('filo_categoria_conservaciones', FiloCategoriaConservacion.all.order(:filo_categoria_conservacion), false)
      set_tabla('filo_fuentes', FiloFuente.all.order(:filo_fuente), false)
    when 'Interacciones' #Tablas secundarias
      set_tabla('filo_def_roles', FiloDefRol.all.order(:filo_def_rol), false)
      set_tabla('filo_def_interacciones', FiloDefInteraccion.all.order(:filo_def_interaccion), false)
    when 'Formaciones & Pisos' #Tablas secundarias
      set_tabla('eco_formaciones', EcoFormacion.all.order(:eco_formacion), false)
      set_tabla('eco_pisos', EcoPiso.all.order(:eco_piso), false)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
end
