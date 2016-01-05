require 'uri'
require 'roo'
require 'pry-rails'
require 'json'
require 'fileutils'



ARGV.each do |i|
	#Lee el nombre del archivo desde la consola
	xlsx_name = i
	#Obtiene el nombre del archivo sin extension
	json_name = File.basename( xlsx_name, ".*" )
	#Crea un archivo json vacio
	json_name = json_name+'.json'
	FileUtils.touch(json_name)

	#Abre el archivo excel.
	book = Roo::Spreadsheet.open(xlsx_name)
	
	final_json = {}
	
	book.sheets.each do |sheet_name|
		sheet = book.sheet(sheet_name)
		
		#solo si la primer columna tiene las referencias
		attributes = Hash[sheet.row(1).map{|x| [x,x]}]
		
		first_row = true
		sheet.each(attributes) do |hash|
			if(!first_row)
				(final_json[sheet_name] ||= []) << hash
			end
			first_row = false
		end
	end
	
	File.open(json_name, "w") do |f|
		f.write(JSON.pretty_generate(final_json))
	end
end

