require 'uri'
require 'roo'
require 'pry-rails'
require 'json'
require 'fileutils'

# Nombre de la primera columna en el archivo excel.
attributes = {
	startup: 'startup',
	website: 'website',
	country: 'country',
	industry: 'industry',
	leader: 'leader',
	leader_name: 'leader_name',
	member_1: 'member_1',
	member_1_name: 'member_1_name',
	member_1_email: 'member_1_email',
	member_2: 'member_2',
	member_2_name: 'member_2_name',
	member_2_email: 'member_2_email',
	description: 'description',
	metrics: 'metrics',
	investment_looking_raise: 'investment_looking_raise',
	logo: 'logo'
}

#Lee el nombre del archivo desde la consola
xlsx_name = ARGV[0]
#Obtiene el nombre del archivo sin extension
json_name = File.basename( xlsx_name, ".*" )
#Crea un archivo json vacio
json_name = json_name+'.json'
FileUtils.touch(json_name)

#Abre el archivo excel.
book = Roo::Spreadsheet.open(xlsx_name)
sheet = book.sheet(0)
count = 1

File.open(json_name, "w") do |f|
	f.write("[")
	sheet.each(attributes) do |hash|
		if(count > 1)
			f.write(JSON.pretty_generate(hash))
			if(count < sheet.last_row)
				f.write(",")
			end
			f.write("\n")
		end
		count += 1
	end
	f.write("]")
end
