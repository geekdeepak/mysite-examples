# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
["108101985909667", "12161711085", "50285729149", "17295379437", "215593611792185", "130979351552", "50112151664", "401356880384", 
	"527858623", "12432941001", "73276865566", "1024756871", "34700327700", "34363100821", "100000958348677" ].each do |page|
		Page.find_or_create_by_page_identifier(page)
end