class AnalysesController < ApplicationController
    include ApplicationHelper
    before_action :set_analysis_flg, only: [:index, :show]
    before_action :authenticate_user! # ログインしていないときはログインページに移動

    def index
        @user = User.find(current_user.id)

        # チャートデータ作成
        books = Book.where(user_id: current_user.id)
        row_data = books.group("strftime('%Y年%m月', created_at)").count # ハッシュの作成
        # 空の年月ハッシュを作る
        data = {}
        11.times do |num|
            date = Date.today
            x = 11 - num
            ym = date - x.months
            ym = ym.strftime("%Y年%m月")
            data[ym] = 0
        end
        # データハッシュを組み込む
        data = data.merge(row_data)
        # ハッシュ配列を作る。各月バージョン。
        rireki = []
        total = 0
        data.each do |val|
             item = {"date" => val[0], "count" => val[1] }
             rireki.push(item)
        end
        # ハッシュ配列を作る。累計バージョン。
        ruikei = []
        data.each do |val|
            total += val[1]
            item = {"date" => val[0], "count" => total }
            ruikei.push(item)
        end

        @data = rireki.to_json
        # @data = ruikei.to_json

        @chart_title = '本の登録数'

    end


    def show
        
    end

    def get_data
        
puts RUIKEI

    end


end
