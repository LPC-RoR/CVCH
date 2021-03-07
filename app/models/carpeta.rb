class CarpetaUnicaValidator < ActiveModel::Validator
  def validate(record)
    if record.perfil.carpetas.map {|carpeta| carpeta.carpeta}.include?(record.carpeta) and not record.perfil.carpetas.map {|carpeta| carpeta.id}.include?(record.id)
      record.errors[:base] << "Este nombre de Carpeta ya la ha usado"
    end
  end
end
 
class Carpeta < ApplicationRecord

  validates_with CarpetaUnicaValidator

	# MARCA CARPETAS QUE NO SE MODIFICAN NI ELIMINAN
	NOT_MODIFY = ['Revisar', 'Excluidas', 'Postergadas', 'Revisadas']

	TABLA_FIELDS = [
		['carpeta', 'show'], 
	]

 	FORM_FIELDS = [
		['carpeta',        'entry'],
		['perfil_id',     'hidden']
	]

	belongs_to :perfil, optional: true

	has_many :clasificaciones
	has_many :publicaciones, through: :clasificaciones

	has_many :herencias
	has_many :equipos, through: :herencias

	validates :carpeta, presence: true

	def btns_control
		not NOT_MODIFY.include?(self.carpeta)
	end
end

