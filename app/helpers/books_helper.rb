module BooksHelper

    def getAmazonAfiLink
        # GoogleAPIコードをアフィリンクにするハッシュを生成
        amazon_afi_link_list = {
            '4GqdwAEACAAJ' => 'https://amzn.to/3aa10KQ', # FACTFULNESS
            '7V8XswEACAAJ' => 'https://amzn.to/39bd6SR', # 完訳 7つの習慣
            '2PW9DwAAQBAJ' => 'https://amzn.to/2vxj7ey', # ２０３０年の世界地図帳
            't369DwAAQBAJ' => 'https://amzn.to/33xHrcK', # 1兆ドルコーチ
            'KZesyAEACAAJ' => 'https://amzn.to/391hxQ1', # こども六法
            'qNMHnwEACAAJ' => 'https://amzn.to/2U8hldD', # 嫌われる勇気
            '8Y1yjwEACAAJ' => 'https://amzn.to/2IZGGQn', # 人を動かす文庫版
            '2SdzBQAAQBAJ' => 'https://amzn.to/2U5mSRT', # 星を継ぐもの
            '_brNxwEACAAJ' => 'https://amzn.to/3a64Ft1', # 催眠ガール
            'JQbNDwAAQBAJ' => 'https://amzn.to/3a5Pj7Z', # その日のまえに
            'l7-1ngEACAAJ' => 'https://amzn.to/33yRmPt', # 三日間の幸福
            '13gDwgEACAAJ' => 'https://amzn.to/2U5Re71', # 鬼滅の刃小説
            'IiiFwwEACAAJ' => 'https://amzn.to/2U20Tvg', # 俺か、俺以外か。
            'vjPMDwAAQBAJ' => 'https://amzn.to/2Un6Guf', # ハイキュー!! 42
            'mYWAAgAAQBAJ' => 'https://amzn.to/2IXw4S2', # ゼロ秒思考
            'EkEcNwAACAAJ' => 'https://amzn.to/2xOMl9y', # 陽気なギャングが地球を回す
            'Vl9DswEACAAJ' => 'https://amzn.to/2U2zN7k', # 「自分の中に毒を持て」新装版
            'NG1TDwAAQBAJ' => 'https://amzn.to/2J1x6wq', # 「自分の中に毒を持て」
            '8Tg7AAAAQBAJ' => 'https://amzn.to/3btOLJ9', # 配達あかずきん
            '48qoDwAAQBAJ' => 'https://amzn.to/2WFGI7Z', # 好きなことしか本気になれない
            'qm9dAwAAQBAJ' => 'https://amzn.to/2QLv1cb', # ひとり暮らしな日々
            'RCkoDgAAQBAJ' => 'https://amzn.to/2xq1lKM', # 最後の医者は桜を見上げて君を想う
# 本屋大賞2020年ノミネート作品
            'OJ6dDwAAQBAJ' => 'https://amzn.to/33MNGtl', # 線は、僕を描く
            'g0cdyAEACAAJ' => 'https://amzn.to/39jDYQx', # 店長がバカすぎて
            'yd7MDwAAQBAJ' => 'https://amzn.to/3bkjhp0', # 夏物語
            'YOvMDwAAQBAJ' => 'https://amzn.to/3by2GOJ', # 熱源
            'vcmlDwAAQBAJ' => 'https://amzn.to/2UBPEsD', # ノースライト
            '8JudDwAAQBAJ' => 'https://amzn.to/2ybMcNN', # むかしむかしあるところに、死体がありました。
            '7QSwDwAAQBAJ' => 'https://amzn.to/39kd2zZ', # ムゲンのｉ ： 上
            'WdAsygEACAAJ' => 'https://amzn.to/2UxuYBW', # ムゲンのi 下
            'kYGsDwAAQBAJ' => 'https://amzn.to/2WJHTU3', # medium 霊媒探偵城塚翡翠
            'mo26DwAAQBAJ' => 'https://amzn.to/2QKyxU4', # ライオンのおやつ
            'znWqDwAAQBAJ' => 'https://amzn.to/2UBflJD', # 流浪の月
# ユーザーの投稿
            'tL9evgAACAAJ' => 'https://amzn.to/2QW04SR', # 手のひらの音符
            'ELR_OQAACAAJ' => 'https://amzn.to/2xCbOD8', # 白昼の死角
            '5TCTCwAAQBAJ' => 'https://amzn.to/3bQKvnw', # 稼ぐ言葉の法則
            'w7nTCQAAQBAJ' => 'https://amzn.to/39AEObK', # アドラー心理学が教える　新しい自分の創めかた
            '48vFCQAAQBAJ' => 'https://amzn.to/2RclCLb', # 免疫学の基本がわかる事典
            '8PNQDwAAQBAJ' => 'https://amzn.to/2S8swkZ', # 最後の医者は雨上がりの空に君を願う（下）
            'Tq80swEACAAJ' => 'https://amzn.to/2zHDTKh', # 虚ろな十字架
            'hfl2uQAACAAJ' => 'https://amzn.to/2ybN1Xf', # モンスター 百田尚樹
            'VHReYgEACAAJ' => 'https://amzn.to/2LE2u5u', # 変身 東野圭吾
            'tvQvAAAACAAJ' => 'https://amzn.to/2C59Nl9', # 秘密 東野圭吾
            'EL0Dz4IEupsC' => 'https://amzn.to/3flWZFn', # 図書館戦争 図書館戦争シリーズ (1) 有川浩
            'vZAduAEACAAJ' => 'https://amzn.to/3fkSGdh', # 図書館危機図書館戦争シリーズ(２) 有川浩
            '_fmtwmObVz8C' => 'https://amzn.to/3cWmueU', # 図書館危機図書館戦争シリーズ(3) 有川浩
            'R-FguAEACAAJ' => 'https://amzn.to/3e006Tc', # 図書館危機図書館戦争シリーズ(４) 有川浩
            'CsZZXwAACAAJ' => 'https://amzn.to/30FymQ2', # 図書館危機図書館戦争シリーズ(５) 有川浩
            'SZhJOgAACAAJ' => 'https://amzn.to/3fmcP2C', # 図書館危機図書館戦争シリーズ(６) 有川浩
            'hjzmDwAAQBAJ' => 'https://amzn.to/2zMLzeC', # キングダム58巻
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 
            # '' => '', # 

        }

        return amazon_afi_link_list
        
    end

    def setAmazonAfiLink(api_id)
        # GoogleAPIコードからアマゾンアフィリンクへ変換
        amazonAfiLinkList = getAmazonAfiLink
        return amazonAfiLinkList[api_id]
    end

    def create_id
        # ランダムな文字列を生成
        random_char = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
        random_id = (0...24).map { random_char[rand(random_char.length)] }.join
        unique_id = check_id(random_id)
        return unique_id
    end

    def check_id(id)
        book = Book.find_by(impression_link: id)
        if book
            puts 'found same id'
            create_id()
        else
            puts 'confirmed unique id in check_id function'
            return id
        end
    end


end
