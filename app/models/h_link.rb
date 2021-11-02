class HLink < ApplicationRecord

	TIPOS = ['link', 'ayuda', 'path']

	TABLA_FIELDS = [
		['texto', 'show'],
		['tipo', 'normal']
	]

	def padre
		self.owner_class.constantize.find(self.owner_id)
	end
end
