class Listing < ApplicationRecord
  belongs_to :user
  has_many :tags, dependent: :destroy
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :price, presence: true
end
