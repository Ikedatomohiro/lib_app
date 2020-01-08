class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user! # ログインしていないときはログインページに移動
  # ログインしていなくても閲覧できるようにする。
  # 特定のページにはログインを要求する
end
