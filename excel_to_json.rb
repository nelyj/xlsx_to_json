require 'uri'
require 'roo'
require 'pry-rails'
require 'json'
require 'fileutils'

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


FileUtils.touch('demoday.json')
book = Roo::Spreadsheet.open("demoday.xlsx")
sheet = book.sheet(0)
count = 1

File.open("demoday.json", "w") do |f|
	sheet.each(attributes) do |hash|
		if(count > 1)
			f.write(hash.to_json)
			f.write(",")
		end

		count += 1
	end
end