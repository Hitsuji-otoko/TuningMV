class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2],
         :authentication_keys => [:username]
  # Youtubeモデルとの関連づけ
  has_many :youtubes, dependent: :destroy

  
  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true

  # user_idを仕様してログインするようオーバーライド
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      # 認証の条件式を変更する
      where(conditions).where(["username = :value", {:value => username}]).first
    else
      where(conditions).first
    end 
  end  

  # 登録時にemailを不要とする
  def email_required?
    false
  end 

  def email_changed?
    false
  end

  # コールバックを受けた時に
  # ユーザが既にアプリケーションの中で認知されているかどうかを判断するメソッド
  def self.find_for_google_oauth2(auth)
    user = User.where(email: auth.info.email).first
    unless user
      user = User.create(username:     auth.info.name,
                         provider: auth.provider,
                         uid:      auth.uid,
                         email:    auth.info.email,
                         access_token:    auth.credentials.token,
                         password: Devise.friendly_token[0, 20])
    end
    user
  end
end
