class User < ApplicationRecord
  include Clearance::User
  has_many :listings, dependent: :destroy
  has_many :bookings, dependent: :destroy
  enum status: [ :customer, :moderator, :oneaboveall]
  mount_uploader :avatar, AvatarUploader

end
