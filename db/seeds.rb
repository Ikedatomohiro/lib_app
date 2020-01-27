# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(account_name: 'ドラえもん', self_introduction: '僕ドラえもんだよ。', email: 'to.tomo.tomohiro@gmail.com', password: 'Tomohir0')

Setting.create(user_id: 1)

Book.create(user_id: 1, isbn:'9784991022173', book_title:'しょぼい喫茶店の本')