# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(email: "hi@hi.com", password: "hihihi")
User.create!(email: "john@hi.com", password: "johnjohn")
User.create!(email: "billy@hi.com", password: "billybilly")

Sub.create!(title: "Cars", description: "These are cars.", user_id: 1)
Sub.create!(title: "Flying cars", description: "These are ONLY cars that fly.", user_id: 1)
Sub.create!(title: "Boats", description: "These are not cars.", user_id: 2)
