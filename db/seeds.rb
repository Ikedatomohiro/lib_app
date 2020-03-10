# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user = User.create(account_name: 'ドラえもん', self_introduction: '僕ドラえもんだよ。', email: 'to.tomo.tomohiro@gmail.com', password: 'Tomohir0', admin_flg: true)
user = User.create(id: 1, uid: "1213404570006646784",
                   provider:
                   "twitter",
                   name: "ぱお@読書のわ",
                   nickname: "paoDokushonowa",
                   location: "",
                   image: "http://pbs.twimg.com/profile_images/12167217442972...",
                   email: "1213404570006646784-twitter@example.com",
                   self_introduction: nil,
                   admin_flg: true,
                   shelf_type: 1,
                   user_type: 1,
                   del_flg: false,
                   )
user = User.create(id: 2,
                   uid: "1232982499694796800",
                   provider: "twitter",
                   name: "どくしょのわのアカ",
                   nickname: "DokushonowaSub",
                   location: "",
                   image: "http://pbs.twimg.com/profile_images/12337504414034...",
                   email: "1232982499694796800-twitter@example.com",
                   self_introduction: "これは幻か。",
                   twitter_link: "https://twitter.com/DokushonowaSub",
                   admin_flg: true,
                   shelf_type: 1,
                   user_type: 1,
                   del_flg: false,
                   )
user = User.create(id: 3,
                   uid: "1138026663948644353",
                   provider: "twitter",
                   name: "ちょ💻パパエンジニア",
                   nickname: "cssk_cho",
                   location: "自分が決めたことはやりきれる。他人が決めたことではできない。",
                   image: "http://pbs.twimg.com/profile_images/11587215925762...",
                   email: "1138026663948644353-twitter@example.com",
                   self_introduction: nil,
                   twitter_link: "https://twitter.com/cssk_cho",
                   admin_flg: true,
                   shelf_type: 1,
                   user_type: 1,
                   del_flg: false,
                   )

Setting.create(id: 1, user_id: 1)
Setting.create(id: 2, user_id: 2)
Setting.create(id: 3, user_id: 3)


