# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.new({fullname: 'Sergio Zambrano', email: 'sergio@xmail.com', username: 'sergio', password: '123456', admin: true})
user2 = User.new({fullname: 'Ariel Camus', email: 'ariel@xmail.com', username: 'ariel', password: '123456', admin: false})
user3 = User.new({fullname: 'Sheyla Pozo', email: 'sheyla@xmail.com', username: 'sheyla', password: '123456', admin: false})

user1.save
user2.save
user3.save
