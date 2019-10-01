require 'open-uri'
class User < ApplicationRecord
  after_create :create_cart

  has_one_attached :image
  has_one :cart
  has_many :products
  has_many :comments

  # validates :username, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  def self.from_omniauth(auth)
    method_name = "#{auth.provider}_auth"
    self.send(method_name, auth) if defined?(method_name)
    # if auth.provider === 'facebook'
    #   facebook_auth(auth)
    # elsif auth.provider === 'google_oauth2'
    #   google_auth(auth)
    # end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def self.facebook_auth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name
      downloaded_image = open(auth.info.image)
      user.image.attach(io: downloaded_image  , filename: "foo.jpg")
      # user.image.attach(auth.info.image)
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.google_auth(auth)
    user = User.where(email: data.email).first
    # user.token = auth.credentials.token
    # user.expires = auth.credentials.expires
    # user.expires_at = auth.credentials.expires_at
    # user.refresh_token = auth.credentials.refresh_token
    unless user
        user = User.create(username: data.name,
           email: data.email,
           password: Devise.friendly_token[0,20],
        )
        user.image = data.image
    end
    user
  end

  def create_cart
    self.cart = Cart.new
  end
end
