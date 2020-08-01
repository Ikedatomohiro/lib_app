class AnalysesController < ApplicationController
    include ApplicationHelper
    before_action :set_analysis_flg, only: [:index, :show]
    before_action :authenticate_user! # ログインしていないときはログインページに移動

    def index
        @user = User.find(current_user.id)

        search_field = 'created_at'
        # search_field = 'reading_end_date'

        @data = search_data(search_field)
        @chart_title = '本の登録数'

        @data_dokuryo = search_data('reading_end_date')
        @chart_title2 = '読了数'
    end


    def search_data(search_field)
        # チャートデータ作成
        books = Book.where(user_id: current_user.id)
        row_data = books.group("strftime('%Y年%m月', #{search_field})").count # 本の読了数

        # 空の年月ハッシュを作る
        data = {}
        13.times do |num|
            date = Date.today
            x = 12 - num
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

        data = rireki.to_json
        # @data = ruikei.to_json
    end

    def show_data
        @user = User.find(current_user.id)
        @data = ''
        search_data(get_data_param[:search_field])
        @chart_title = '読了数'
    end

    private
    def get_data_param
        params.permit(:search_field, :authenticity_token)

    end



end
