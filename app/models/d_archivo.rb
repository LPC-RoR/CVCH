class DArchivo < ApplicationRecord

 	FORM_FIELDS = [
		['archivo', 'file_field']
	]

	mount_uploader :archivo, ArchivoCargaUploader
end
