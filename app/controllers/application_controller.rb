class ApplicationController < ActionController::Base

	include Seguridad
	include Inicia
	include IniciaAplicacion

	include Capitan

	include Tablas

	include ProcesaEstructura

	include Taxonomia

	helper_method :version_activa, :dog?, :admin?, :nomina?, :general?, :anonimo?, :dog_email, :dog_name, :perfil_activo?, :perfil_activo, :mi_seguridad?, :publico?, :seguridad, :public_controllers
	helper_method :menu_tablas, :tb_index, :tb_item, :first_tabla_index
	helper_method :bandeja_display?
	helper_method :uf_del_dia, :uf_fecha, :enlaces_general, :enlaces_perfil, :limpia_nombre

	helper_method :lexer

	helper_method :especie_a_estructura

	# ************************************************************************** COLECCINES DE ESTADOS
 
 	def st_colecciones(modelo, estado)
		case modelo
		when 'Causa'
			modelo.constantize.where(estado: estado).order(created_at: :desc)
		when 'Cliente'
			modelo.constantize.where(estado: estado).order(:razon_social)
		when 'Consultoria'
			modelo.constantize.where(estado: estado).order(created_at: :desc)
		when 'TarFactura'
			modelo.constantize.where(estado: estado).order(documento: :desc)
		end
	end

	# Este método se usa para construir un nombre de directorio a partir de un correo electrónico.
	def archivo_usuario(email, params)
		email.split('@').join('-').split('.').join('_')
	end

	def number? string
	  true if Float(string) rescue false
	end

	def params_to_date(prms, date_field)
		DateTime.new(prms["#{date_field}(1i)"].to_i, prms["#{date_field}(2i)"].to_i, prms["#{date_field}(3i)"].to_i, 0, 0, 0, "#{Time.zone.utc_offset/3600}")
	end

end
