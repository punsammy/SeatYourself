# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#

restaurant1 = Restaurant.create(name: "Quelque Chose", address: "58 Bon St.", phone_number: "416-555-1234", description: "Fine French Dining", capacity: 40, special: "La Salade Gourmet", opening_time: Restaurant.default_opening_time, closing_time: Restaurant.default_closing_time)

restaurant2 = Restaurant.create(name: "Jolly Jiggs Pizzeria", address: "10 Paisano St.", phone_number: "416-555-9671", description: "Supreme pies!", capacity: 10, special: "Jalapeno Kaboom", opening_time: Restaurant.default_opening_time, closing_time: Restaurant.default_closing_time)
