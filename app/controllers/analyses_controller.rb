class AnalysesController < ApplicationController
    include ApplicationHelper
    before_action :set_analysis_flg, only: [:index, :show]
    before_action :set_default_data, only: [:index, :show]
    before_action :authenticate_user! # ログインしていないときはログインページに移動

    def index
    end

    def show
        @key = get_data_param[:search_index]
        case @key
        when 'L8cGeK6B' # 読み始めた数（冊）
            model         = Book
            search_field  = 'reading_start_date'
            @yaxis_second = '読み始めた数（冊）'
            row_data      = search_count_data(model, search_field)
        when 'fB6gaHRN' # 読了数（冊）
            model         = Book
            search_field  = 'reading_end_date'
            @yaxis_second = '読了数（冊）'
            row_data      = search_count_data(model, search_field)
        when 'dJ4frtbZ' # 感想登録（回）
            model         = Impression
            search_field  = 'created_at'
            @yaxis_second = '感想登録（回）'
            row_data      = search_count_data(model, search_field)
        when 'r5J4WVBw' # 感想文字（文字）
            model         = Impression
            search_field  = 'updated_at'
            @yaxis_second = '感想文字（文字）'
            target        = model.where(user_id: current_user.id)
            row_data = {}
            target.each do |impression|
                length = impression.impression.length
                ym     = impression.updated_at.strftime('%Y年%m月')
                if row_data[ym].nil?
                    row_data[ym] = 0
                end
                row_data[ym] += length
            end
        when 'Ux5CP2kc' # ツイート（回）
            model         = Impression
            search_field  = 'tweeted_time'
            @yaxis_second = 'ツイート（回）'
            row_data      = search_count_data(model, search_field)
        when 'Kv9LYjn3' # いいねされた（回）
            model         = Impression
            search_field  = 'created_at'
            @yaxis_second = 'いいねされた（回）'
            # チャートデー タ作成
            target = model.where(user_id: current_user.id)
            row_data = target.group("strftime('%Y年%m月', #{search_field})").sum(:like_count)
        end

        @data_second = create_json(row_data)
    end

    def search_count_data(model, search_field)
        # チャートデータ作成
        target = model.where(user_id: current_user.id)
        row_data = target.group("strftime('%Y年%m月', #{search_field})").count
    end

    def create_json(row_data)

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
        # data = ruikei.to_json
    end

    def set_default_data
        @key         = 'cN4QZYGW'
        model        = Book
        search_field = 'created_at'
        @yaxis       = '本の登録数（冊）'
        row_data     = search_count_data(model, search_field)
        @data        = create_json(row_data)
    end

    private
    def get_data_param
        params.permit(:search_index)
    end

end
