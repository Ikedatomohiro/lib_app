class User < ApplicationRecord
  has_one :setting, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :shleves, dependent: :destroy
  has_many :impressions, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable,
         :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    if user
      random_id = user.random_id
      # アイコンが変わっていればランダムIDを変更する
      if user.image != auth.info.image || user.random_id.nil?
        random_id = createRamdomId
      end

      user.update(
        image:              auth.info.image,
        name:               auth.info.name,
        nickname:           auth.info.nickname,
        location:           auth.info.location,
        oauth_token:        auth.credentials.token,
        oauth_token_secret: auth.credentials.secret,
        twitter_link:       auth.info.urls.Twitter,
        random_id:          random_id 
        )
    puts 'Update User!'

    else
      user = User.create(
        uid:                auth.uid,
        provider:           auth.provider,
        email:              User.dummy_email(auth),
        password:           Devise.friendly_token[0, 20],
        image:              auth.info.image,
        name:               auth.info.name,
        nickname:           auth.info.nickname,
        location:           auth.info.location,
        oauth_token:        auth.credentials.token,
        oauth_token_secret: auth.credentials.secret,
        twitter_link:       auth.info.urls.Twitter,
        random_id:          createRamdomId
      )
      setting = Setting.create(
        user_id: user.id
      )
    end
    # Twitterアイコンをダウンロードする
    download_image_icon(user.random_id, auth)
    # userデータを返す
    user
  end

  # 画像アップロード
  mount_uploader :user_icon, ImageUploader

  scope :impression_private, -> {joins(:setting).select("users.*, settings.*")}

  # ログインを維持する
  def remember_me
    true
  end

  private
 
  # ダミーのemailを取得（deviseではemailがないと登録できないので）
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  # ランダムな文字列を作成
  def self.createRamdomId
    require "securerandom"
    random_id = SecureRandom.uuid
    puts "create random id:#{random_id}"
    return random_id
  end

  # アイコンをダウンロード
  def self.download_image_icon(random_id, auth)
    require 'open-uri'
    url = auth.info.image
    file = "public/downloads/images/user/user_icon_#{random_id}.jpg"
    open(file, 'w') do |pass|
      open(url) do |recieve|
        pass.write(recieve.read)
      end
    end
  end

end
