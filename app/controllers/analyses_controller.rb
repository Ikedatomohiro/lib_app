class AnalysesController < ApplicationController
    include ApplicationHelper
    before_action :set_analysis_flg, only: [:index, :show]
    before_action :authenticate_user! # ログインしていないときはログインページに移動


    def index
        @user = User.find(current_user.id)


    end

    def show
        
    end


end
