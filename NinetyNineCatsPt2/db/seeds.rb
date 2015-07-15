Cat.destroy_all
CatRentalRequest.destroy_all
User.destroy_all

# require 'Bcrypt'

Cat.create!(user_id: 1, birth_date: '10/01/1991', color: 'black', name: 'Daniel', sex: 'M', description: 'Just whatever.')
Cat.create!(user_id: 1, birth_date: '24/12/1991', color: 'white', name: 'Maxim', sex: 'M', description: 'He goes by a lot of things.')
Cat.create!(user_id: 1, birth_date: '01/01/0001', color: 'orange', name: 'Jesus', sex: 'M', description: 'Dont piss off his dad.')
Cat.create!(user_id: 1, birth_date: '05/10/1994', color: 'brown', name: 'Green Tea', sex: 'F', description: 'She prefers Earl Grey actually.')

CatRentalRequest.create!(cat_id: 1, start_date: '02/01/2000', end_date: '05/01/2000', user_id: 2) #A
CatRentalRequest.create!(cat_id: 1, start_date: '01/01/2000', end_date: '06/01/2000', user_id: 2) #B
CatRentalRequest.create!(cat_id: 1, start_date: '01/01/2000', end_date: '03/01/2000', user_id: 2) #C
CatRentalRequest.create!(cat_id: 1, start_date: '05/01/2000', end_date: '06/01/2000', user_id: 2) #D
CatRentalRequest.create!(cat_id: 1, start_date: '03/01/2000', end_date: '04/01/2000', user_id: 2) #E
CatRentalRequest.create!(cat_id: 1, start_date: '07/01/2000', end_date: '08/01/2000', user_id: 2) #F
CatRentalRequest.create!(cat_id: 2, start_date: '03/01/2000', end_date: '04/01/2000', user_id: 2) #G
CatRentalRequest.create!(cat_id: 2, start_date: '07/01/2000', end_date: '08/01/2000', user_id: 2) #H
CatRentalRequest.create!(cat_id: 1, start_date: '02/01/2000', end_date: '05/01/2000', user_id: 2) #F


User.create!(username: "Nalgene", password: "password")
User.create!(username: "Don Draper", password: "luckystrike")
User.create!(username: "Peggy Olson", password: "password")

