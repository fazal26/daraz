require 'open-uri'

class User < ApplicationRecord
  rolify

  has_one_attached :image, dependent: :destroy
  
  has_one :cart, dependent: :destroy

  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  accepts_nested_attributes_for :roles

  validates :username, presence: true

  def self.from_omniauth(auth)
    user_auth_obj = {
      uid: auth[:uid],
      provider: auth[:provider],
      email: auth.dig(:info, :email),
      username: auth.dig(:info, :name),
      downloaded_image: open(auth.dig(:info, :image))
    }
    authorize_omni_auth_user(user_auth_obj)
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:devise.facebook_data] && session[:devise.facebook_data][:extra][:raw_info]
        user.email = data[:email] if user.email.blank?
      end
    end
  end

  private

  def self.authorize_omni_auth_user(user_obj)
    where(provider: user_obj[:provider], uid: user_obj[:uid]).first_or_create do |user|
      user.email = user_obj[:email]
      user.password = Devise.friendly_token[0, 20]
      user.username = user_obj[:username]
      user.image.attach(io: user_obj[:downloaded_image], filename: "foo")
      user.add_role(:buyer)
      user.save
    end
  end
end
