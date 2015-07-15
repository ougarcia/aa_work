# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
first_cat_values = { name: "fluffy", birth_date: DateTime.now - 10.minutes, color: "Blue", sex: "M", description: "kind of chubby" }
second_cat_values = { name: "spot", birth_date: DateTime.now - 30.minutes, color: "Blue", sex: "F", description: "is actually a dog" }
third_cat_values = { name: "Sphynx", birth_date: DateTime.now - 100.years, color: "Orange", sex: "M", description: "14 stories tall" }
Cat.create!(first_cat_values)
Cat.create!(second_cat_values)
Cat.create!(third_cat_values)


first_rental = {cat_id: 1, start_date: Date.parse("2015-01-01"), end_date: Date.parse("2015-01-30")}
second_rental = {cat_id: 1, start_date: Date.parse("2015-01-15"), end_date: Date.parse("2015-01-30")}
third_rental = {cat_id: 1, start_date: Date.parse("2015-01-01"), end_date: Date.parse("2015-02-14")}
four_rental = {cat_id: 2, start_date: Date.parse("2015-01-01"), end_date: Date.parse("2015-01-30")}
five_rental = {cat_id: 2, start_date: Date.parse("2015-01-15"), end_date: Date.parse("2015-01-30")}
six_rental = {cat_id: 2, start_date: Date.parse("2015-01-01"), end_date: Date.parse("2015-02-14")}

CatRentalRequest.create!(first_rental)
CatRentalRequest.create!(second_rental)
CatRentalRequest.create!(third_rental)
CatRentalRequest.create!(four_rental)
CatRentalRequest.create!(five_rental)
CatRentalRequest.create!(six_rental)

# x = {cat_id: 1, start_date: Date.parse("2015-01-01"), end_date: Date.parse("2015-01-12"), status: "APPROVED"}
