class Tag < ApplicationRecord
  belongs_to :listing
  validates :tag, uniqueness: true
end
