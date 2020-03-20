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

end
