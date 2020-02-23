# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user = User.create(account_name: 'ドラえもん', self_introduction: '僕ドラえもんだよ。', email: 'to.tomo.tomohiro@gmail.com', password: 'Tomohir0', admin_flg: true)
user = User.create(self_introduction: '僕ドラえもんだよ。', email: 'to.tomo.tomohiro@gmail.com', password: 'Tomohir0',  admin_flg: true, uid: '1213404570006646784', provider: 'twitter', name: '管理者', nickname: 'paoDokushonowa', location: '', image: 'http://pbs.twimg.com/profile_images/1216721744297222144/ChMA2H0-_normal.jpg')


Book.create(user_id: 1, api_id: '4O_UDgAAQBAJ', api_path: 'https://www.googleapis.com/books/v1/volumes/4O_UDgAAQBAJ', title: '磯野家の謎', impression_link: '9vcIFUmDgWpt9bfIByQ4zIig')