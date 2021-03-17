module IniciaAplicacion
	extend ActiveSupport::Concern

	def inicia_app
		if @perfil.carpetas.empty?
			@perfil.carpetas.create(carpeta: 'Revisar')
			@perfil.carpetas.create(carpeta: 'Excluidas')
			@perfil.carpetas.create(carpeta: 'Postergadas')
			@perfil.carpetas.create(carpeta: 'Revisadas')
		end
	end

end