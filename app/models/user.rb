class User < ApplicationRecord
  has_one :setting, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :shleves, dependent: :destroy
  has_many :impressions, dependent: :destroy
  has_many :contacts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable,
         :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    if user
      user.update(
        image:              auth.info.image,
        name:               auth.info.name,
        nickname:           auth.info.nickname,
        location:           auth.info.location,
        oauth_token:        auth.credentials.token,
        oauth_token_secret: auth.credentials.secret,
        twitter_link:       auth.info.urls.Twitter,
        )

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
      )
      setting = Setting.create(
        user_id: user.id
      )
    end
 
    user
  end

  # 画像アップロード
  mount_uploader :user_icon, ImageUploader

  scope :impression_private, -> {joins(:setting).select("users.*, settings.*")}
  private
 
  # ダミーのemailを取得（deviseではemailがないと登録できないので）
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
