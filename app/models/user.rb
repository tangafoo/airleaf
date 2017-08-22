class User < ApplicationRecord
  include Clearance::User
  has_many :listings, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :authentications, dependent: :destroy
  enum status: [ :customer, :moderator, :oneaboveall]
  mount_uploader :avatar, AvatarUploader

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      name: auth_hash["extra"]["raw_info"]["name"],
      email: auth_hash["extra"]["raw_info"]["email"],
      remote_avatar_url: auth_hash["info"]["image"],
      password: SecureRandom.hex(3)
      )
    user.customer!
    user.authentications << authentication
    return user
  end

  def fb_token
    x = self.authentications.find_by(provider: 'facebook')
    return x.token unless x.nil?
  end

end
