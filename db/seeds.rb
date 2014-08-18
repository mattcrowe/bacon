# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#5.times do |i|
#  Client.create!(name: "Client ##{i}", contact: "A client.")
#end

Client.create!(name: "Bob's Donuts", contact: "Bob Smith", email:"bob@bobsdonuts.com", rate:65.00)
Project.create!(client_id: 1, name: 'Home Page')
Project.create!(client_id: 1, name: 'Sugary Lander')
Project.create!(client_id: 1, name: 'Maintenance')

Client.create!(name: "Taco Hut", contact: "Jeff Filimino", email:"jeffster@tacohut.com", rate:65.00)
Project.create!(client_id: 2, name: 'New Web Site')
Project.create!(client_id: 2, name: 'Map Feature')

Client.create!(name: "Turbo Toilet Paper", contact: "Flappy", email:"oleflappy@turbotoiletpaper.com", rate:40.00)
Project.create!(client_id: 3, name: 'Contact Page')
Project.create!(client_id: 3, name: 'Inventory Feature')